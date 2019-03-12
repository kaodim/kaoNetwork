//
//  KaoNotificationBannerView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 09/11/2018.
//

import Foundation
import UIKit

public enum KaoBannerType {
    case success, error, banner, message
}

public class KaoNotificationBannerView: UIView {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var iconHeight: NSLayoutConstraint!
    @IBOutlet private weak var title: KaoLabel!
    @IBOutlet private weak var message: KaoLabel!
    @IBOutlet private weak var titleLeading: NSLayoutConstraint!

    private var contentView: UIView!
    private var defaultSpaceHeight: CGFloat = 33
    private var defaultSpaceWidth: CGFloat = 55
    public var dismissTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoNotificationBannerView")
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

        title.font = .kaoFont(style: .bold, size: .regular)
        message.font = .kaoFont(style: .regular, size: .small)
        dismissButton.setImage(UIImage.imageFromDesignIos("ic_close_light"), for: .normal)
    }

    public func configure(_ style: KaoBannerType, titleText: String?, messageText: String?) -> CGFloat {
        title.text = titleText
        message.text = messageText

        switch style {
        case .error:
            cardView.backgroundColor = .kaoColor(.crimson)
            icon.image = UIImage.imageFromDesignIos("ic_alert")
            iconHeight.constant = 20
            titleLeading.constant = 15
        case .success:
            cardView.backgroundColor = .kaoColor(.shamRock)
            icon.image = UIImage.imageFromDesignIos("ic_success")
            iconHeight.constant = 20
            titleLeading.constant = 15
        case .message:
            cardView.backgroundColor = .kaoColor(.gableGreen)
            icon.image = nil
            iconHeight.constant = 0
            titleLeading.constant = 0
        case .banner:
            cardView.backgroundColor = .kaoColor(.gableGreen)
            icon.image = UIImage.imageFromDesignIos("pn_logo")
            iconHeight.constant = 50
            titleLeading.constant = 15
        }
        backgroundColor = cardView.backgroundColor

        let screenWidth = UIScreen.main.bounds.width - iconHeight.constant - titleLeading.constant - defaultSpaceWidth
        let titleHeight = titleText?.height(withConstrainedWidth: screenWidth, font: title.font) ?? 0
        let messageHeight = messageText?.height(withConstrainedWidth: screenWidth, font: message.font) ?? 0
        let iconFinalHeight = iconHeight.constant + defaultSpaceHeight
        let labelFinalHeight = titleHeight + messageHeight + defaultSpaceHeight

        return (iconFinalHeight > labelFinalHeight) ? iconFinalHeight : labelFinalHeight
    }

    @IBAction private func dismissDidTap() {
        dismissTapped?()
    }
}

