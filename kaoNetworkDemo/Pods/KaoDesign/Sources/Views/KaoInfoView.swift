//
//  KaoInfoView.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 23/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

public class KaoInfoView: UIView {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var title: KaoLabel!
    @IBOutlet private weak var subTitle: KaoLabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var iconWidth: NSLayoutConstraint!
    @IBOutlet private weak var firstButton: KaoButton!
    @IBOutlet private weak var secondButton: KaoButton!
    @IBOutlet private weak var buttonViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var bottomButtonView: NSLayoutConstraint!

    private var contentView: UIView!
    public var firstButtonTapped: (() -> Void)?
    public var secondButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoInfoView")
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }

    private func configureViews() {
        contentView = loadFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)

        cardView.addCornerRadius()
        cardView.backgroundColor = .kaoColor(.twilightBlue)
        cardView.addBorderLine(color: .kaoColor(.aquaIsland))

        title.font = .kaoFont(style: .regular, size: .small)
        title.textColor = .kaoColor(.jellyBean)

        subTitle.font = .kaoFont(style: .lightItalic, size: .small)
        subTitle.textColor = .kaoColor(.jellyBean)

        firstButton.configure(type: .secondary, size: .small)
        secondButton.configure(type: .secondary, size: .small)
    }

    public func enableFirstButton(_ enable: Bool = true) {
        firstButton.isEnabled = enable
    }

    public func enableSecondButton(_ enable: Bool = true) {
        secondButton.isEnabled = enable
    }

    public func configure(_ title: NSAttributedString, subTitle: NSAttributedString? = nil, image: UIImage? = nil, firstButtonTitle: String? = nil, secondButtonTitle: String? = nil) {
        self.title.attributedText = title

        if subTitle != nil {
            self.subTitle.attributedText = subTitle
        }

        configureIcon(image)
        configureButton(firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle)
        setNeedsLayout()
    }

    private func configureIcon(_ image: UIImage?) {
        iconWidth.constant = image == nil ? 0 : 21
        icon.image = image
    }

    private func configureButton(firstButtonTitle: String?, secondButtonTitle: String?) {
        if firstButtonTitle != nil || secondButtonTitle != nil {
            buttonViewHeight.constant = 25
            bottomButtonView.constant = 15
            if let firstButtonTitle = firstButtonTitle {
                firstButton.isHidden = false
                firstButton.setTitle(firstButtonTitle, for: .normal)
            } else {
                firstButton.isHidden = true
            }
            if let secondButtonTitle = secondButtonTitle {
                secondButton.isHidden = false
                secondButton.setTitle(secondButtonTitle, for: .normal)
            } else {
                secondButton.isHidden = true
            }
        } else {
            firstButton.isHidden = true
            secondButton.isHidden = true
            buttonViewHeight.constant = 0
            bottomButtonView.constant = 0
        }
    }

    @IBAction private func firstButtonTap() {
        firstButtonTapped?()
    }

    @IBAction private func secondButtonTap() {
        secondButtonTapped?()
    }
}
