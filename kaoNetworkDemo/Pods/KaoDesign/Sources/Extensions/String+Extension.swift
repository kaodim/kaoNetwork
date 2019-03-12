//
//  String+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 09/11/2018.
//

import Foundation

public extension String {

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        if self.contains("\n") {
            let seperateTexts = self.components(separatedBy: "\n")
            let heights = seperateTexts.map({ (text) -> CGFloat in
                let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
                return ceil(boundingBox.height)
            })
            let totalHeight = heights.reduce(0, +)
            return totalHeight
        } else {
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
            return ceil(boundingBox.height)
        }
    }

    func toDate(_ format: String = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ") -> Date? {
        let dateFormatter = DateFormatter.kaoDefault()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    func isVersionNewer(_ compareVersion: String) -> Bool {
        if self.compare(compareVersion, options: .numeric) == .orderedDescending {
            return true
        } else {
            return false
        }
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func containPhoneCharOnly() -> Bool {
        let alphabetsRegEx = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[- /0-9]*$"
        let stringTest = NSPredicate(format:"SELF MATCHES %@", alphabetsRegEx)
        return stringTest.evaluate(with: self)
    }

    func isStrongPassword() -> Bool {
        let regEx = "(?=^.{8,}$)(?=.*\\d)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return passwordTest.evaluate(with: self)
    }

    func lineSpaced(spacing: CGFloat = 1.67, height: CGFloat = 20, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let attributedString = NSAttributedString(
            string: self,
            attributes: [NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle.kaoDefaultParagraphStyle(spacing: spacing, height: height, alignment: alignment)]
        )
        return attributedString
    }

    func removeAllWhiteSpace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    func attributeString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}

public extension NSMutableParagraphStyle {
    class func kaoDefaultParagraphStyle(spacing: CGFloat = 1.67, height: CGFloat = 20, alignment: NSTextAlignment = .left) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.alignment = alignment
        return paragraphStyle
    }
}
