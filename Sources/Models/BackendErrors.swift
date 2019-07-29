//
//  BackendErrors.swift
//  kaoNetwork
//
//  Created by Augustius on 23/07/2019.
//

import Foundation

public struct BackendErrors: ApprovedErrors {
    public var errors: [BackendError]
}

public struct BackendError: Decodable {
    public var key: String
    public var message: String
}

public extension BackendErrors {
    func getAllMessage() -> String? {
        return errors.map({ $0.message }).joined(separator: "\n")
    }
}
