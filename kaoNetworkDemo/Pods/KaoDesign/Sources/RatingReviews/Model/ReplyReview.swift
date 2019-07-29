//
//  ReplyReview.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

public struct ReplyReview {
    public let id: Int
    public let comment: String
    public let createdAt: String
    public let canEdit: Bool?
}

public extension ReplyReview {
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let comment = json["comment"] as? String,
            let createdAt = json["created_at"] as? String
            else {
                return nil
        }

        self.id = id
        self.comment = comment
        self.createdAt = createdAt
        self.canEdit = json["can_edit"] as? Bool
    }
}
