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
    public static func handleErrorResponse<T>(response: AFDataResponse<T>, error: Error, needAuth: Bool = false, completion: (_ resultError: Any) -> Void) {

        if let statusCode = response.response?.statusCode, let statusCodeError = NetworkErrorStatusCode(rawValue: statusCode) {
            switch statusCodeError {
            case .unauthorized:
                if needAuth { // this bcs backend return 401 when sign in / sign up
                    handleUnauthorized()
                } else {
                    tryToReadBackendErrorMessage(response: response, completion: completion)
                }
            case .internalServerError:
                handleInternalServerError()
            }
        } else {
            tryToReadBackendErrorMessage(response: response, completion: completion)
        }
    }

    public static func tryToReadBackendErrorMessage<T>(response: AFDataResponse<T>, completion: (_ resultError: Any) -> Void) {
        if let data = response.data {
            do {
                let error = try JSONSerialization.jsonObject(with: data, options: [])
                if let payload = error as? [String:Any], !(payload.isEmpty) {
                    completion(payload)
                }
            } catch {
                completion(error.localizedDescription)
            }
        } //else {
            //completion(error.localizedDescription)
        //}
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
    public static func requestJSON(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, showLoader: Bool = false, needAuth: Bool, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {

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


        AF.request(url, method: method, parameters: finalParameters, encoding: encodingType, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                completion(.success(json))
            case .failure(let error):

                handleErrorResponse(response: response, error: error, needAuth: needAuth, completion: { resultError in
                    completion(.failure(resultError))
                })
            }

            if showLoader {
                KaoLoading.shared.hide()
            }
        }
    }

    public static func requestData(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, showLoader: Bool = false, needAuth: Bool, completion: @escaping (_ result: NetworkResult<Data>) -> Void) {
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

        AF.request(url, method: method, parameters: finalParameters, encoding: encodingType, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                handleErrorResponse(response: response, error: error, needAuth: needAuth, completion: { resultError in
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
     static func postMultiPartJSON(_ url: URLConvertible, header: HTTPHeaders, attachmentData: Data, fileName: String, progressHandler: @escaping (_ progress: Progress) -> Void, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {

        AF.upload(multipartFormData: { (multipartData) in
            self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
            }, to: url,method: .post,headers: header).responseJSON(completionHandler: { (response) in

                switch response.result {
                          case .success(let data):
                                completion(.success(data))
                          case .failure(let error):
                             completion(.failure(error))

                          }


            })



//        AF.upload(multipartFormData: { (multipartData) in
//            self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
//        }, to: url, method: .post, headers: header, encodingCompletion: { (encodingResult) in
//            switch encodingResult {
//            case .success(let request, _, _):
//                request.uploadProgress(closure: progressHandler)
//                self.uploadFileJSON(dataRequest: request, completion: { (result) in
//                    completion(result)
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
    }

    /// Send POST Multipart network call request
    ///
    /// - Parameters:
    ///   - endpoint: attachment upload endpoint
    ///   - attachmentData: atatchment data
    ///   - fileName: atatchment file name
    ///   - progressHandler: progress handler
    ///   - completion: success(NetworkResult<Data>) / failure(String)
     static func postMultiPartData(_ url: URLConvertible, header: HTTPHeaders, attachmentData: Data, fileName: String, progressHandler: @escaping (_ progress: Progress) -> Void, completion: @escaping (_ result: NetworkResult<Data>) -> Void) {



        AF.upload(multipartFormData: { (multipartData) in
                   self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
                   }, to: url,method: .post,headers: header).responseData(completionHandler: { (response) in

                       switch response.result {
                                 case .success(let data):
                                       completion(.success(data))
                                 case .failure(let error):
                                    completion(.failure(error))

                                 }


                   })

//        AF.upload(multipartFormData: { (multipartData) in
//            self.multipartDataHandler(formData: multipartData, data: attachmentData, fileName: fileName)
//        }, to: url, method: .post, headers: header, encodingCompletion: { (encodingResult) in
//            switch encodingResult {
//            case .success(let request, _, _):
//                request.uploadProgress(closure: progressHandler)
//                self.uploadFileData(dataRequest: request, completion: { (result) in
//                    completion(result)
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
    }

    /// Handle multipart data encoding
    ///
    /// - Parameters:
    ///   - formData: multipart data
    ///   - data: file data
    ///   - fileName: file name
     static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String) {

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


    /// Upload encoded data to server
    ///
    /// - Parameters:
    ///   - request: upload request
    ///   - completion: success(NetworkResult<Any>) / failure(String)
    private static func uploadFileJSON(dataRequest: DataRequest, completion: @escaping (_ result: NetworkResult<Any>) -> Void) {
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

    /// Upload encoded data to server
    ///
    /// - Parameters:
    ///   - request: upload request
    ///   - completion: success(NetworkResult<Data>) / failure(String)
    private static func uploadFileData(dataRequest: DataRequest, completion: @escaping (_ result: NetworkResult<Data>) -> Void) {
        dataRequest.validate()
            .responseData(completionHandler: { (response) in
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

    private static func printRequest(headers: HTTPHeaders, parameters: [String: Any]) {
        #if STAGING
        print("===============[Headers]==================")
        print(String(data: try! JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted), encoding: .utf8 ) ?? [:])

        print("===============[Parameters]===============")
        print(String(data: try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted), encoding: .utf8 ) ?? [:])
        print("==========================================")
        #elseif OMEGA
        print("MACRO FAILED")
        #else
        print("CHECK YOUR CODE")
        #endif
    }
}
