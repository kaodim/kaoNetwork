//
//  KaoBottomView.swift
//  KaoDesign
//
//  Created by Ramkrishna on 29/05/2019.
//

import UIKit

public class KaoBottomView: UIView {

    @IBOutlet private weak var firstStackView: UIStackView!
    @IBOutlet private weak var secondStackView: UIStackView!
    @IBOutlet private weak var thirdStackView: UIStackView!
    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var descLabel: KaoLabel!
    @IBOutlet private weak var amtLabel: KaoLabel!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var topView: UIView!

    private var contentView: UIView!
    public var buttonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoBottomView")
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

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        amtLabel.font = .kaoFont(style: .medium, size: 24.0)
        contentView.dropShadow(shadowRadius: 3.0, shadowColor: UIColor.black, shadowOffSet: CGSize(width: 0, height: 1.0), shadowOpacity: 0.2)
        topView.addCornerRadius(8.0)
    }

    public func configureNewView(_ newView: UIView) {
        secondStackView.isHidden = true
        thirdStackView.isHidden = true
        firstStackView.addArrangedSubview(newView)
    }

    public func configure(_ title: NSAttributedString? = nil, desc: NSAttributedString, amt: NSAttributedString? = nil, _ buttonTitle: String?, descLines: Int = 0) {
        secondStackView.isHidden = false
        thirdStackView.isHidden = false

        configureTitle(title)
        descLabel.isHidden = false
        descLabel.attributedText = desc
        descLabel.numberOfLines = descLines
        configureAmt(amt)
        configureButton(buttonTitle)
        setNeedsLayout()
    }

    private func configureTitle(_ title: NSAttributedString?) {
        if let title = title {
            titleLabel.isHidden = false
            titleLabel.attributedText = title
        } else {
            titleLabel.isHidden = true
        }
    }

    private func configureAmt(_ amt: NSAttributedString?) {
        if let amt = amt {
            amtLabel.isHidden = false
            amtLabel.attributedText = amt
        } else {
            amtLabel.isHidden = true
        }
    }

    private func configureButton(_ title: String?) {
        if let title = title {
            buttonView.isHidden = false
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .normal)
        } else {
            buttonView.isHidden = true
        }
    }

    @IBAction private func buttonAction(_ sender: Any) {
        self.buttonTapped?()
    }
}
