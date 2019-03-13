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
}

extension KaoNetworkErrorHandler {
    /// Handle error for each network request
    ///
    /// - Parameters:
    ///   - response: network respose
    ///   - error: error request
    ///   - completion: error completion be called in network request
    public static func handleErrorJSON(response: DataResponse<Any>, error: Error, completion: (_ resultError: Any) -> Void) {

            guard let statusCode = response.response?.statusCode, let statusCodeError = NetworkErrorStatusCode(rawValue: statusCode) else {
                completion(error.localizedDescription)
                return
            }

            switch statusCodeError {
            case .unauthorized:
                handleUnauthorizedError()
            case .internalServerError:
                handleInternalServerError()
            }

            completion(statusCodeError.statusCodeDescription)
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

        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("🎉 \(url):\n \(json)")
                completion(.success(json))
            case .failure(let error):
                print("💩 \(url): \(error.localizedDescription)")
                handleErrorJSON(response: response, error: error, completion: { resultError in
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

    static func handleUnauthorizedError() {
        let topView = UIApplication.topViewController()
        let retryAction = (topView as? KaoNetworkProtocol)?.retry
        topView?.presentTimeOutError(retryAction)
    }
}

