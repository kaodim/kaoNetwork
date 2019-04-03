//
//  Dictionary+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 03/04/2019.
//

import Foundation

public extension Dictionary {

    mutating func merged(with another: [Key: Value]) {
        var result = self
        for entry in another {
            result[entry.key] = entry.value
        }
        self = result
    }
}
