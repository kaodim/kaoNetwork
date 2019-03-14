//
//  KaoNetworkErrorHandler.swift
//  Pods-kaoNetwork
//
//  Created by Kelvin Tan on 3/4/19.
//

import Foundation
import UIKit
import Alamofire
import KaoDesign

private var defaultParameters: [String: Any] = {
    var parameters: [String: Any] = [:]
    parameters["preferred_timezone"] = TimeZone.current.secondsFromGMT()/3600 as Any
    parameters["platform"] = "ios"
    parameters["device_id"] = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? ""
    parameters["os"] = UIDevice.current.systemVersion
    parameters["app_version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return parameters
}()

public protocol KaoNetworkErrorHandler {
    static func handleUnauthorized()
    static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String)
}

extension KaoNetworkErrorHandler {

    /// Handle error for each network request
    ///
    /// - Parameters:
    ///   - response: network respose
    ///   - error: error request
    ///   - completion: error completion be called in network request
    public static func handleErrorResponse<T>(response: DataResponse<T>, error: Error, completion: (_ resultError: Any) -> Void) {

        guard let statusCode = response.response?.statusCode, let statusCodeError = NetworkErrorStatusCode(rawValue: statusCode) else {
//            completion(error.localizedDescription)
            return
        }

        if let data = response.data {
            do {
                let error = try JSONSerialization.jsonObject(with: data, options: [])
                if let payload = error as? [String:Any], !(payload.isEmpty) {
                    completion(payload)
                }
            } catch {
                completion(error.localizedDescription)
            }
        } else {
            completion(error.localizedDescription)
        }

        switch statusCodeError {
        case .unauthorized:
            handleUnauthorized()
        case .internalServerError:
            handleInternalServerError()
        }

//        completion(statusCodeError.statusCodeDescription)
    }

    /// Request Response JSON
    ///
    /// - Parameters:
    ///   - url: ADA's endpoint
    ///   - method:  condition for different type of request.
    ///   - parameters: URL parameters
    ///   - headers:
    ///   - showLoader:
    ///   - completion: success(NetworkResult<Any>) / failure(String)
    public static func requestJSON(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, showLoader: Bool = false, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {

        if showLoader {
            KaoLoading.shared.show()
        }

        var parameters: [String: Any]? = parameters == nil ? [:] : parameters
        parameters?.merge(defaultParameters, uniquingKeysWith: { (first, _) in first })

        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("🎉 \(url):\n \(json)")
                completion(.success(json))
            case .failure(let error):
                print("💩 \(url): \(error.localizedDescription)")
                handleErrorResponse(response: response, error: error, completion: { resultError in
                    completion(.failure(resultError))
                })
            }

            if showLoader {
                KaoLoading.shared.hide()
            }
        }
    }

    public static func requestData(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, showLoader: Bool = false, completion: @escaping (_ result: NetworkResult<Data>) -> Void) {
        if showLoader {
            KaoLoading.shared.show()
        }

        var parameters: [String: Any]? = parameters == nil ? [:] : parameters
        parameters?.merge(defaultParameters, uniquingKeysWith: { (first, _) in first })

        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                print("🎉 \(url):\n \(data)")
                completion(.success(data))
            case .failure(let error):
                print("💩 \(url): \(error.localizedDescription)")
                handleErrorResponse(response: response, error: error, completion: { resultError in
                    completion(.failure(resultError))
                })
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

    static func handleUnauthorized() {
        let topView = UIApplication.topViewController()
        let retryAction = (topView as? KaoNetworkProtocol)?.retry
        topView?.presentTimeOutError(retryAction)
    }
}

extension KaoNetworkErrorHandler {

    /// Send POST Multipart network call request
    ///
    /// - Parameters:
    ///   - endpoint: attachment upload endpoint
    ///   - attachmentData: atatchment data
    ///   - fileName: atatchment file name
    ///   - progressHandler: progress handler
    ///   - completion: success(NetworkResult<Any>) / failure(String)
    public static func postMultiPart(_ url: URLConvertible, header: HTTPHeaders, attachmentData: Data, fileName: String, progressHandler: @escaping (_ progress: Progress) -> Void, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {

        Alamofire.upload(multipartFormData: { (multipartData) in
            self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
        }, to: url, method: .post, headers: header, encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let request, _, _):
                request.uploadProgress(closure: progressHandler)
                self.uploadFile(dataRequest: request, completion: { (result) in
                    completion(result)
                })
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    /// Handle multipart data encoding
    ///
    /// - Parameters:
    ///   - formData: multipart data
    ///   - data: file data
    ///   - fileName: file name
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

        print("original called")

        formData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
    }


    /// Upload encoded data to server
    ///
    /// - Parameters:
    ///   - request: upload request
    ///   - completion: success(NetworkResult<Any>) / failure(String)
    private static func uploadFile(dataRequest: DataRequest, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {
        dataRequest.validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    completion(.success(json))
                case .failure(let error):
                    handleErrorResponse(response: response, error: error, completion: { resultError in
                        completion(.failure(resultError))
                    })
                }
            })
    }
}

