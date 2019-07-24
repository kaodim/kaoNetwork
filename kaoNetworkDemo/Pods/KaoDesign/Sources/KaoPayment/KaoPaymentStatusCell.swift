//
//  KaoPaymentStatusCell.swift
//  KaoDesign
//
//  Created by Augustius on 11/06/2019.
//

import Foundation

public enum KaoPaymentStatus {
    case fail, process, partial
}

public class KaoPaymentStatusCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var cardViewTrailing: NSLayoutConstraint!
    @IBOutlet private weak var cardViewLeading: NSLayoutConstraint!
    @IBOutlet private weak var cardViewTop: NSLayoutConstraint!
    @IBOutlet private weak var cardViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var messageLabel: KaoLabel!
    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var button: KaoButton!

    public var buttonTap: (() -> Void)?

    override public func awakeFromNib() {
        super.awakeFromNib()
        cardView.addCornerRadius()
        button.configure(type: .whiteOnly)
        messageLabel.font = UIFont.kaoFont(style: .regular, size: 15)
    }

    public func configure(_ message: String, buttonTitle: String? = nil, status: KaoPaymentStatus) {
        messageLabel.text = message
        configureStatus(status)

        if let buttonTitle = buttonTitle {
            button.setTitle(buttonTitle, for: .normal)
            buttonView.isHidden = false
        } else {
            buttonView.isHidden = true
        }
    }

    public func configureEdge(_ edge: UIEdgeInsets) {
        cardViewTop.constant = edge.top
        cardViewBottom.constant = edge.bottom
        cardViewLeading.constant = edge.left
        cardViewTrailing.constant = edge.right
    }

    private func configureStatus(_ status: KaoPaymentStatus) {
        switch status {
        case .fail:
            iconView.isHidden = false
            icon.image = UIImage.imageFromDesignIos("ic_paymfailed")
            cardView.backgroundColor = .kaoColor(.crimson)
        case .process:
            iconView.isHidden = false
            icon.image = UIImage.imageFromDesignIos("ic_paymprocess")
            cardView.backgroundColor = .kaoColor(.kaodimOrange)
        case .partial:
            iconView.isHidden = true
            cardView.backgroundColor = .kaoColor(0x276ef0)
        }
    }

    @IBAction private func buttonTapped() {
        buttonTap?()
    }
}
