//
//  KaoNoSearchFound.swift
//  KaoDesign
//
//  Created by augustius cokroe on 26/11/2018.
//

import Foundation
import UIKit

public class KaoNoSearchFound: UIView {

    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var messageLabel: KaoLabel!
    @IBOutlet private weak var descLabel: KaoLabel!

    private var contentView: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func configureViews() {
        contentView = loadFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        icon.image = UIImage.imageFromDesignIos("img_nosearchresults")
        messageLabel.font = UIFont.kaoFont(style: .regular, size: .small)
        messageLabel.textColor = UIColor.kaoColor(.bigStone)
        descLabel.font = UIFont.kaoFont(style: .regular, size: .small)
        descLabel.textColor = UIColor.kaoColor(.bigStone)
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoNoSearchFound")
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }

    public func configure(message: NSAttributedString, desc: NSAttributedString) {
        messageLabel.attributedText = message
        descLabel.attributedText = desc
    }
}
