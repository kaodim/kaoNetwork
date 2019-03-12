//
//  UITextView+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 14/02/2019.
//

import Foundation

public extension UITextView {

    func addPlaceholderText(_ text: String, textColor: UIColor = UIColor.kaoColor(.silver)) {
        if let placeholderLabel = self.placeholderLabel() {
            placeholderLabel.isHidden = false
        } else {
            let placeholderLabel = UILabel(frame: CGRect(x: 5, y: 10, width: 100, height: 20))
            placeholderLabel.font = self.font
            placeholderLabel.text = text
            placeholderLabel.textColor = textColor
            placeholderLabel.sizeToFit()
            placeholderLabel.tag = 99
            placeholderLabel.isHidden = false
            self.addSubview(placeholderLabel)
        }
    }

    func removePlaceholder() {
        viewWithTag(99)?.removeFromSuperview()
    }

    func placeholderLabel() -> UILabel? {
        for subview in self.subviews where subview.tag == 99 {
            return subview as? UILabel
        }
        return nil
    }
}
