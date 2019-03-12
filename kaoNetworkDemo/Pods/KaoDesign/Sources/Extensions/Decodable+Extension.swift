//
//  Decodable+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
