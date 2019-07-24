//
//  KaoPayHeaderCell.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//

import Foundation

public class KaoPayHeaderCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var amountLabel: KaoLabel!
    @IBOutlet private weak var seperatorLine: UIView!

    public var arrowButtonTap: ((_ showMore: Bool) -> Void)?

    override public func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = UIFont.kaoFont(style: .regular, size: 15)
        amountLabel.font = UIFont.kaoFont(style: .medium, size: 24)
        hideSeperatorLine(false)
    }

    public func configure(_ title: String, amount: String) {
        titleLabel.text = title
        amountLabel.text = amount
    }

    public func hideSeperatorLine(_ hide: Bool = true) {
        seperatorLine.isHidden = hide
    }
}
