//
//  KaoLinkButton.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 24/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class KaoLinkButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshView()
    }

    override public func prepareForInterfaceBuilder() {
        refreshView()
    }

    public func refreshView() {
        // Common logic goes here
        setAttributes()
    }

    private func setAttributes() {
        titleLabel?.textColor = .kaoColor(.curiousBlue)
        setTitleColor(.kaoColor(.curiousBlue), for: .normal)
        tintColor = .kaoColor(.curiousBlue)
        titleLabel?.font = .kaoFont(style: .medium, size: .regular)
        adjustsImageWhenHighlighted = false
    }
}
