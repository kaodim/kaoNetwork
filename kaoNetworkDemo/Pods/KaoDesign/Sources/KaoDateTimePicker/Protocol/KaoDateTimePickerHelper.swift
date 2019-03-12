//
//  KaoDateTimePickerHelper.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

protocol KaoDateTimePickerHelper {}

extension KaoDateTimePickerHelper {

    func getSelectionColor() -> UIColor {
        return UIColor.blue
    }

    func formattedDateFromString(dateString: String, withFormat format: String, havingFormat old: String? = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ") -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = old

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            outputFormatter.timeZone = TimeZone.init(identifier: "UTC")
            outputFormatter.locale = Locale(identifier: "en_US")
            return outputFormatter.string(from: date)
        }

        return nil
    }

    func loadDayTimesInterval() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"

        let dateNow = Date.init()

        formatter.dateFormat = "HH"
        let dateCurrent = formatter.string(from: dateNow)

        var timeArray: [String] = []

        let lastTime: Double = 24.0
        var currentTime: Double = Double(dateCurrent) ?? 0.0
        let incrementMinutes: Double = 30.0 // increment by  minutes

        while currentTime <= lastTime {
            currentTime += (incrementMinutes/60)
            let hours = (floor(currentTime))
            let minutes = (currentTime.truncatingRemainder(dividingBy: 1.0)*60.0)

            let printedHour = Int(hours)
            let printedMinutes = Int(minutes)
            if minutes == 0 {
                if hours >= 12 {
                    timeArray.append("\(printedHour):00 PM")
                } else {
                    timeArray.append("\(printedHour):00 AM")
                }
            } else {
                if hours < 24 {
                    if hours >= 12 {
                        timeArray.append("\(printedHour):\(printedMinutes) PM")
                    } else {
                        timeArray.append("\(printedHour):\(printedMinutes) AM")
                    }
                }
            }
        }
        return timeArray
    }

}

extension UILabel {

    func formattedString(style: UIFont.Weight = .regular, fontSize size: CGFloat) {
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.textColor = UIColor(red:0.07, green:0.14, blue:0.18, alpha:1)
        self.textAlignment = .center
        let textContent = self.text
        let textString = NSMutableAttributedString(string: textContent ?? "", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: style)
            ])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.11
        paragraphStyle.alignment = .center
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        self.attributedText = textString
        self.sizeToFit()
    }

}

extension CALayer {
    func manualLayouting(view: UIView? = nil) {
        view?.backgroundColor = UIColor.white
        self.borderColor   = UIColor.kaoColor(KaoColorHex.prussianBlue).cgColor
        self.masksToBounds = true
        self.cornerRadius = 3
        self.borderWidth = 1
        self.borderColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1).cgColor
        self.shadowOffset = CGSize(width: 0, height: 2)
        self.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.07).cgColor
        self.shadowOpacity = 1
        self.shadowRadius = 4
    }
}


