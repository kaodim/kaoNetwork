//
//  SelectedReviewTag.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

public struct SelectedReviewTag {
    public let id: String
    public let name: String
    public var iconUrl: String
}

public extension SelectedReviewTag {
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? String,
            let name = json["name"] as? String,
            let iconUrl = json["icon_url"] as? String
            else { return nil }

        self.id = id
        self.name = name
        self.iconUrl = iconUrl
    }
}

extension SelectedReviewTag {
    static func initList(json: Any?) -> [SelectedReviewTag]? {
        guard let arrayDictionary = json as? [[String: Any]] else { return nil }
        return arrayDictionary.compactMap({ SelectedReviewTag(json: $0) })
    }
}
