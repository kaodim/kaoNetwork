//
//  RatingReviewLocalization.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

public enum RatingReviewLocalizationKey: String {
    case ratings, reviews, reply, replied, replyingTo, typeAMessage, cancel, send, editYourComment, update, edit, complimented
}

public struct RatingReviewLocalization {

    public init() {
        self.allLocalizations = [:]
    }

    var allLocalizations: [String: String] = [:]

    func translate(_ localizationKey: RatingReviewLocalizationKey) -> String {
        return self.allLocalizations[localizationKey.rawValue] ?? "-\(localizationKey.rawValue)-"
    }

    public mutating func setTranslation(_ text: String, for key: RatingReviewLocalizationKey) {
        allLocalizations[key.rawValue] = text
    }
}
