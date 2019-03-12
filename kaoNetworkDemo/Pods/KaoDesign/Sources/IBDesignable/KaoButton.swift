//
//  KaoButton.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 24/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

public enum KaoButtonType {
    case primary, secondary, textOnly, dismiss
}

@IBDesignable
public class KaoButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override public func prepareForInterfaceBuilder() {
        configure()
    }

    public override var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize

        if imageView?.image != nil {
            imageEdgeInsets = .init(top: 7, left: 14, bottom: 7, right: 14+7)
            titleEdgeInsets = .init(top: 0, left: 14+7, bottom: 0, right: 14)
        } else {
            imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
            titleEdgeInsets = .init(top: 0, left: 14, bottom: 0, right: 14)
        }

        let adjustedWidth = intrinsicContentSize.width + imageEdgeInsets.left + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + imageEdgeInsets.top + imageEdgeInsets.bottom

        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }

    public func configure(type: KaoButtonType = .primary, size: KaoFontSize = .regular) {
        // Common logic goes here
        addCornerRadius()
        setAttributes(type: type, size: size)
    }

    private func setAttributes(type: KaoButtonType, size: KaoFontSize) {
        switch type {
        case .primary:
            setBackgroundColor(color: .kaoColor(.cardinal), forState: .highlighted)
            setBackgroundColor(color: .kaoColor(.silver), forState: .disabled)
            setBackgroundColor(color: .kaoColor(.crimson), forState: .normal)
            titleLabel?.textColor = .white
            setTitleColor(.white, for: .highlighted)
            tintColor = .white
        case .secondary:
            setBackgroundColor(color: .kaoColor(.midnight), forState: .highlighted)
            setBackgroundColor(color: .kaoColor(.silver), forState: .disabled)
            setBackgroundColor(color: .kaoColor(.prussianBlue), forState: .normal)
            titleLabel?.textColor = .white
            setTitleColor(.white, for: .highlighted)
            tintColor = .white
        case .textOnly:
            setBackgroundColor(color: .kaoColor(.mercury), forState: .highlighted)
            setBackgroundColor(color: .clear, forState: .disabled)
            setBackgroundColor(color: .clear, forState: .normal)
            titleLabel?.textColor = .kaoColor(.curiousBlue)
            setTitleColor(.kaoColor(.curiousBlue), for: .normal)
            setTitleColor(.kaoColor(.curiousBlue), for: .highlighted)
            setTitleColor(.kaoColor(.whiteLilac), for: .disabled)
            tintColor = .kaoColor(.curiousBlue)
        case .dismiss:
            setBackgroundColor(color: .kaoColor(.whiteThree), forState: .highlighted)
            setBackgroundColor(color: .kaoColor(.whiteThree), forState: .disabled)
            setBackgroundColor(color: .kaoColor(.whiteThree), forState: .normal)
            titleLabel?.textColor = .kaoColor(.greyishBrown)
            setTitleColor(.kaoColor(.greyishBrown), for: .normal)
            tintColor = .kaoColor(.greyishBrown)
        }

        titleLabel?.font = .kaoFont(style: .medium, size: size)
        adjustsImageWhenHighlighted = false
    }
}

