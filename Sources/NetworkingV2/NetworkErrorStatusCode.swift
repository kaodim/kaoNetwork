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

public enum KaoNetworkResult<T: Decodable> {
    case success(T)
    case failure(KaoError)
    case decodeFailure(String)
}

