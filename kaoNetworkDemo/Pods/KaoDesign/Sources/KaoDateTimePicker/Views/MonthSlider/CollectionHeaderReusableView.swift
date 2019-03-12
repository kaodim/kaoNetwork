//
//  CollectionHeaderReusableView.swift
//  Kaodim
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var monthLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func layouting() {
        monthLabel.lineBreakMode = .byWordWrapping
        monthLabel.numberOfLines = 0
        monthLabel.textColor = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1)
        let textContent = monthLabel.text ?? ""
        let textString = NSMutableAttributedString(string: textContent, attributes: [
            NSAttributedString.Key.font: UIFont.kaoFont(style: .medium, size: KaoFontSize.large)
            ])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.17
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: textRange)
        monthLabel.attributedText = textString
        monthLabel.sizeToFit()
    }
    
}
