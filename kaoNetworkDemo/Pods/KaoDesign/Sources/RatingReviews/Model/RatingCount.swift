//
//  RatingCount.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/04/2019.
//

import Foundation

public struct RatingCount {
    public let ratingText: String
    public let count: Int
}

public extension RatingCount {
    init?(json: [String: Any]) {
        guard
            let ratingText = json["rating_text"] as? String,
            let count = json["count"] as? Int
            else { return nil }

        self.ratingText = ratingText
        self.count = count
    }
}

public extension RatingCount {
    static func initList(json: Any?) -> [RatingCount]? {
        guard let arrayDictionary = json as? [[String: Any]] else { return nil }
        return arrayDictionary.compactMap({ RatingCount(json: $0) })
    }
}
