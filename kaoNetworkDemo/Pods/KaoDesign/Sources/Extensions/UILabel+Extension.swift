//
//  UILabel+Extension.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 23/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {

    func addLineSpacing(_ lineSpacing: CGFloat? = nil , lineHeightMultiple: CGFloat? = nil) {
        guard let labelText = self.text else { return }

        let defaultSpace = ((self.font.pointSize + 6) / self.font.pointSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing ?? defaultSpace
        paragraphStyle.lineHeightMultiple = lineHeightMultiple ?? 0

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
