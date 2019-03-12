//
//  KaoPagination.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

public struct KaoPagination: Decodable {
    public var currentPage: Int?
    public var nextPage: Int?
    public var prevPage: Int?
    public var totalCount: Int?
    public var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case nextPage = "next_page"
        case prevPage = "prev_page"
        case totalCount = "total_count"
        case totalPages = "total_pages"
    }
}

/// remove init below once we all use decodable
extension KaoPagination {
    public init?(json: [String: Any]?) {
        self.currentPage = json?["current_page"] as? Int
        self.nextPage = json?["next_page"] as? Int
        self.prevPage = json?["prev_page"] as? Int
        self.totalCount = json?["total_count"] as? Int
        self.totalPages = json?["total_pages"] as? Int
    }
}
