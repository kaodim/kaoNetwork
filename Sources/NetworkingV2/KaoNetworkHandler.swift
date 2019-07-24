//
//  KaoNetworkHandler.swift
//  kaoNetwork
//
//  Created by Augustius on 23/07/2019.
//

import Foundation
import UIKit
import Alamofire
import KaoDesign

var defaultParameters: [String: Any] = {
    var parameters: [String: Any] = [:]
    parameters["preferred_timezone"] = TimeZone.current.secondsFromGMT()/3600 as Any
    parameters["platform"] = "ios"
    parameters["device_id"] = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? ""
    parameters["os"] = UIDevice.current.systemVersion
    parameters["app_version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    parameters["device_type"] = "mobile"
    return parameters
}()

public protocol KaoNetworkHandler {
    associatedtype T: Decodable
    static func handleUnauthorized()
    static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String)
    static func printRequest(headers: HTTPHeaders, parameters: [String: Any])
    static func printSuccessResponse(data: Data?)
    static func printErrorResponse(data: Data?)
}

extension KaoNetworkHandler {

    public static func handleErrorResponse<T>(response: DataResponse<T>, error: Error, needAuth: Bool = false) -> KaoError {

        if let statusCode = response.response?.statusCode, let statusCodeError = NetworkErrorStatusCode(rawValue: statusCode) {
            switch statusCodeError {
            case .unauthorized:
                if needAuth { // this bcs backend return 401 when sign in / sign up
                    handleUnauthorized()
                }
            case .internalServerError:
                handleInternalServerError()
            }
        }

        let resultError = tryToReadBackendErrorMessage(response: response)
        return resultError
    }

    public static func tryToReadBackendErrorMessage<T>(response: DataResponse<T>) -> KaoError {
        var resultError = KaoError()
        if let data = response.data {
            do {
                let error = try JSONSerialization.jsonObject(with: data, options: [])
                if let payload = error as? [String: Any], !(payload.isEmpty) {
                    resultError.errorDict = payload
                }
            } catch {
                let errorStatusCode = " (\(response.response?.statusCode.description ?? ""))"
                resultError.errorString = error.localizedDescription + errorStatusCode
            }
        }
        return resultError
    }

    public static func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, showLoader: Bool = false, needAuth: Bool, completion: @escaping (_ result: KaoNetworkResult<T>) -> Void) {
        if showLoader {
            KaoLoading.shared.show()
        }

        var finalParameters = defaultParameters
        if let parameters = parameters {
            finalParameters.merged(with: parameters)
        }

        var encodingType: ParameterEncoding = URLEncoding.default
        if method == .post || method == .patch || method == .delete {
            encodingType = JSONEncoding.default
        }

        printRequest(headers: headers ?? [:], parameters: finalParameters)

        Alamofire.request(url, method: method, parameters: finalParameters, encoding: encodingType, headers: headers).validate().responseData { (response) in

            switch response.result {
            case .success(let data):
                self.printSuccessResponse(data: data)
                do {
                    let decodeObj = try T.decode(from: data)
                    completion(.success(decodeObj))
                } catch let error {
                    completion(.decodeFailure(error.localizedDescription))
                }
            case .failure(let error):
                self.printErrorResponse(data: response.data)
                let resultError = self.handleErrorResponse(response: response, error: error, needAuth: needAuth)
                completion(.failure(resultError))
            }

            if showLoader {
                KaoLoading.shared.hide()
            }
        }
    }

    static func handleInternalServerError() {
        let topView = UIApplication.topViewController()
        let network = (topView as? KaoNetworkProtocol)
        let retryAction = network?.retry

        topView?.presentInternalServerError(retryAction)
    }
}

extension KaoNetworkHandler {

    public static func uploadAttachment(_ url: URLConvertible, method: HTTPMethod = .post, header: HTTPHeaders, attachmentData: Data, fileName: String, progressHandler: @escaping (_ progress: Progress) -> Void, completion: @escaping (_ result: KaoNetworkResult<T>) -> Void) {

        Alamofire.upload(multipartFormData: { (multipartData) in
            self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
        }, to: url, method: method, headers: header, encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let request, _, _):
                request.uploadProgress(closure: progressHandler)
                self.uploadFileData(dataRequest: request, completion: { (result) in
                    completion(result)
                })
            case .failure(let error):
                var errorResult = KaoError()
                errorResult.errorString = error.localizedDescription
                completion(.failure(errorResult))
            }
        })
    }

    public static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String) {

        let fileNameString = fileName as NSString
        let fileExtension = fileNameString.pathExtension.lowercased()
        let mimeType: String

        switch fileExtension {
        case "jpg", "jpeg":
            mimeType = "image/jpeg"
        case "png":
            mimeType = "image/png"
        case "pdf":
            mimeType = "application/pdf"
        default:
            mimeType = "text/plain"
        }

        formData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
    }

    private static func uploadFileData(dataRequest: DataRequest, completion: @escaping (_ result: KaoNetworkResult<T>) -> Void) {
        dataRequest.validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    self.printSuccessResponse(data: data)
                    do {
                        let decodeObj = try T.decode(from: data)
                        completion(.success(decodeObj))
                    } catch let error {
                        completion(.decodeFailure(error.localizedDescription))
                    }
                case .failure(let error):
                    self.printErrorResponse(data: response.data)
                    let resultError = self.handleErrorResponse(response: response, error: error)
                    completion(.failure(resultError))
                }
            })
    }
}
