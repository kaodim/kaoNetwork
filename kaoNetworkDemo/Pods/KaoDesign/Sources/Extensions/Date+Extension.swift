//
//  Date+Extension.swift
//  KaodimIosDesign
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import Foundation

public extension DateFormatter {
    class func kaoDefault() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        dateFormatter.calendar = gregorianCalendar as Calendar?
        return dateFormatter
    }
}

public extension Date {

    func toLongString() -> String {
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }

    func toMediumString() -> String {
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }

    func toShortString() -> String {
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }

    func toOrdinaralFormat() -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: self)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal

        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.dateFormat = "MMM yyyy"

        return "\(day!) \(dateFormatter.string(from: self))"
    }

    func toString(_ format: String = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ") -> String {
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func isGreaterThanDate(_ dateToCompare : Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }

    func isLessThanDate(_ dateToCompare : Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }

    func isEqualToSelectedDate(_ dateToCompare : Date) -> Bool {
        var isEqualTo = false
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        return isEqualTo
    }

    func addDays(_ daysToAdd : Int) -> Date {
        let secondsInDays : TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : Date = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }

    func addHours(_ hoursToAdd : Int) -> Date {
        let secondsInHours : TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : Date = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }

    func roundUpMin(_ roundValue : Float) -> Date {
        var component = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self)
        let roundMin = ceil(Float(component.minute ?? 0) / roundValue) * roundValue
        component.minute = Int(roundMin)
        return Calendar.current.date(from: component) ?? self
    }

    func getTime() -> String {
        let dateFromat = DateFormatter.kaoDefault()
        dateFromat.dateFormat = "h:mm a"
        return dateFromat.string(from: self)
    }

    func getDay() -> String {
        let dateFromat = DateFormatter.kaoDefault()
        dateFromat.dateFormat = "EE"
        return dateFromat.string(from: self)
    }

    func pickerDateFormat(showTime: Bool) -> String {
        return "\(getDay()), \(toString("dd MMM yyyy")) \(showTime ? "- \(getTime().removeAllWhiteSpace())" : "")"
    }

    func newDateFormat() -> String {
        let timeRange = self.timeIntervalSinceNow * -1
        switch timeRange {
        case 0...5:
            return NSLocalizedString("now", comment: "")
        case 5...60:
            return NSLocalizedString("few_seconds_ago", comment: "")
        case 60...120:
            return NSLocalizedString("minute_ago", comment: "")
        default:
            return self.messageDateFormat()
        }
    }

    func messageDateFormat() -> String {
        var output: String = "\(toMediumString()), \(getTime())"
        let calendar = Calendar.current

        if calendar.isDateInToday(self) {
            output = "Today, \(getTime())"
        } else if calendar.isDateInYesterday(self) {
            output = "Yesterday, \(getTime())"
        }
        return output
    }

    func resetTimeTo(hour:Int = 0, min:Int = 0, sec:Int = 0) -> Date {
        var component = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self)
        component.hour = hour
        component.minute = min
        component.second = sec
        return NSCalendar.current.date(from: component) ?? self
    }
}
