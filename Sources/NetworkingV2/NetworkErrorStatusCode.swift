//
//  NetworkErrorStatusCode.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/6/19.
//

import Foundation

protocol NetworkStatusCodeDescription {
    var statusCodeDescription: String { get }
}

public enum NetworkErrorStatusCode: Int, NetworkStatusCodeDescription {
    case unauthorized = 401
    case internalServerError = 500

    var statusCodeDescription: String {
        switch self {
        case .unauthorized:
            return "Error: Unauthorized (401)"
        case .internalServerError:
            return "Error: Internal Server Error (500)"
        }
    }
}

public enum KaoNetworkResult<T: Decodable, E: ApprovedErrors> {
    case success(T)
    case successButDecodeFail(String)
    case failure(E)
    case failAndDecodeFail(String)
}

public extension KaoNetworkResult {
    func toDataSourceResult() -> DataSourceResult<T> {
        switch self {
        case .success(let object):
            return .success(object)
        case .successButDecodeFail(let errMsg):
            return .failure(errMsg)
        case .failure(let errMsg):
            return .failure(errMsg.getAllMessage() ?? "")
        case .failAndDecodeFail(let errMsg):
            return .failure(errMsg)
        }
    }
}

public enum KaoUploadNetworkResult<T: Decodable> {
    case success(T)
    case failure(String)
    case successButDecodeFail(String)
}

public extension KaoUploadNetworkResult {
    func toDataSourceResult() -> DataSourceResult<T> {
        switch self {
        case .success(let object):
            return .success(object)
        case .successButDecodeFail(let errMsg):
            return .failure(errMsg)
        case .failure(let errMsg):
            return .failure(errMsg)
        }
    }
}

public enum DataSourceResult<T: Decodable> {
    case success(T)
    case failure(String)
}


