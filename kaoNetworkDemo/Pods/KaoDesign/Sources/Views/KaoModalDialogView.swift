//
//  KaoModalDialogView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 09/11/2018.
//

import Foundation
import UIKit

public class KaoModalDialogView: UIView {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var iconHeight: NSLayoutConstraint!
    @IBOutlet private weak var title: KaoLabel!
    @IBOutlet private weak var message: KaoLabel!
    @IBOutlet private weak var firstButton: KaoButton!
    @IBOutlet private weak var secondButton: KaoButton!

    private var contentView: UIView!
    public var dismissTapped: (() -> Void)?
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
        let nib = UIView.nibFromDesignIos("KaoModalDialogView")
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
        let dismissImage = UIImage.imageFromDesignIos("ic_close_dark")?.resizeImage(targetHeight: 10)
        dismissButton.setImage(dismissImage, for: .normal)
        title.font = UIFont.kaoFont(style: .bold, size: .large)
        message.font = UIFont.kaoFont(style: .regular, size: .regular)
        secondButton.configure(type: .textOnly)
    }

    public func configure(_ image: UIImage? = nil, titleText: String, messageText: NSAttributedString,  firstButtonTitle: String? = nil, secondButtonTitle: String? = nil) {
        title.text = titleText
        message.attributedText = messageText
        configureIcon(image)
        configureButton(firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle)
    }

    private func configureIcon(_ image: UIImage?) {
        guard let image = image else { return }
        icon.image = image

        if image.size.width > icon.bounds.width {
            iconHeight.constant = image.size.height * (icon.bounds.width / image.size.width)
        } else {
            iconHeight.constant = 150
        }
    }

    private func configureButton(firstButtonTitle: String?, secondButtonTitle: String?) {
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
    }

    @IBAction private func dismissButtonTap() {
        dismissTapped?()
    }

    @IBAction private func firstButtonTap() {
        firstButtonTapped?()
    }

    @IBAction private func secondButtonTap() {
        secondButtonTapped?()
    }

}
