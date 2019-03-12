//
//  NetworkResult.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/5/19.
//

import Foundation

/// Result type for API calling with 2 types of response
///
/// - success: `T` of generic object.
/// - failure: `ErrorType` of any objects that conform to `ErrorType` protocol.
public enum NetworkResult<T> {
    case success(T)
    case failure(Any)
}

