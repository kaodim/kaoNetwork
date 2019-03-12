//
//  DateTimeModel.swift
//  Kaodim
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

public struct DateTimeModel: Codable {
    let datePickers: [DateTimeDatePicker]?

    enum CodingKeys: String, CodingKey {
        case datePickers = "date_pickers"
    }
}

public struct DateTimeDatePicker: Codable, Equatable {

    public static func == (lhs: DateTimeDatePicker, rhs: DateTimeDatePicker) -> Bool {
        return true
    }

    let month: String?
    let surchargeDates: [DateTimeSurchargeDate]?

    enum CodingKeys: String, CodingKey {
        case month
        case surchargeDates = "surcharge_dates"
    }
}

public struct DateTimeSurchargeDate: Codable, Equatable {

    let date: String?
    let amount: Int?
    let amountText: String?
    let surchargable, available: Bool?

    enum CodingKeys: String, CodingKey {
        case date, amount
        case amountText = "amount_text"
        case surchargable, available
    }

    public static func == (lhs: DateTimeSurchargeDate, rhs: DateTimeSurchargeDate) -> Bool {
        return true
    }
}

//MARK:- Time Model
public struct TimeModel: Codable {
    let surchargeTimes: [SurchargeTime]?

    enum CodingKeys: String, CodingKey {
        case surchargeTimes = "surcharge_times"
    }
}

public struct SurchargeTime: Codable, Equatable {
    let time: String?
    let amount: Int?
    let amountText: String?
    let surchargable, available: Bool?

    enum CodingKeys: String, CodingKey {
        case time, amount
        case amountText = "amount_text"
        case surchargable, available
    }

    public static func == (lhs: SurchargeTime, rhs: SurchargeTime) -> Bool {
        return true
    }
}

