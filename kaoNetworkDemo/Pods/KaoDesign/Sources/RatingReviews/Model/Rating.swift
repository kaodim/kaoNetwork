//
//  Rating.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/04/2019.
//

import Foundation

public struct Rating {
    public let ratingCount: Int
    public let reviewCount: Int
    public let ratingAverage: Double
    public let ratingCountGrouped: [RatingCount]
}

public extension Rating {
    init?(json: [String: Any]) {
        guard
            let ratingCount = json["rating_count"] as? Int,
            let reviewCount = json["reviews_count"] as? Int,
            let ratingAverage = json["rating_average"] as? Double
            else { return nil }

        self.ratingCount = ratingCount
        self.reviewCount = reviewCount
        self.ratingAverage = ratingAverage
        self.ratingCountGrouped = RatingCount.initList(json: json["rating_count_grouped"]) ?? []
    }
}

public extension Rating {
    static func initList(json: Any?) -> [Rating]? {
        guard let arrayDictionary = json as? [[String: Any]] else { return nil }
        return arrayDictionary.compactMap({ Rating(json: $0) })
    }
}
