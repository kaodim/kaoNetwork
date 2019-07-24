//
//  KaoError.swift
//  kaoNetwork
//
//  Created by Augustius on 23/07/2019.
//

import Foundation

public struct KaoError {
    var errorString: String?
    var errorDict: [String: Any]?
}

public extension KaoError {
    func getErrorMessage() -> String? {
        if let errorString = self.errorString, !errorString.isEmpty {
            return errorString
        } else if let errorDict = self.errorDict, let errors = errorDict["errors"] as? [[String: Any]] {
            let allErrorMsg = errors.map({ $0["message"] as? String ?? "" })
            let joinedErrorMsg = allErrorMsg.joined(separator: "\n")
            return joinedErrorMsg
        } else {
            return nil
        }
    }
}
