//
//  KaoPayMethod.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//
//  https://github.com/kaodim/kaodim-api-spec/blob/master/ada/payloads/service_request_summary.md

import Foundation

public enum KaoPayMethod: String {
    case kaodimpay, payAfterService = "pay_on_complete", cashOnComplete = "cash_on_complete"
}

public extension KaoPayMethod {

    static func initList(list: [String]) -> [KaoPayMethod]? {
        return list.compactMap({
            KaoPayMethod(rawValue: $0)
        })
    }
}

public struct KaoPayMethodDetail {
    public let payMethod: KaoPayMethod
    public let title: String
    public let message: String

    public init(_ payMethod: KaoPayMethod, title: String, message: String) {
        self.payMethod = payMethod
        self.title = title
        self.message = message
    }

}
