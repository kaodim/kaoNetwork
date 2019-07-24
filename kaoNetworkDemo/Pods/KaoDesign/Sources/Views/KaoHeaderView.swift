//
//  KaoHeaderView.swift
//  KaoDesign
//
//  Created by Ramkrishna on 27/05/2019.
//

import Foundation
import UIKit

public class KaoHeaderView: UIView {

    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var topSpace: NSLayoutConstraint!
    @IBOutlet private weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpace: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpace: NSLayoutConstraint!

    private var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoHeaderView")
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

        titleLabel.font = .kaoFont(style: .semibold, size: 16.0)
        titleLabel.textColor = .kaoColor(.black)
    }

    public func configure(_ title: NSAttributedString) {
        configureText(title)
    }

    public func configure(_ title: String) {
        configureText(NSAttributedString.init(string: title))
    }

    public func configureEdge(_ edge: UIEdgeInsets) {
        topSpace.constant = edge.top
        bottomSpace.constant = edge.bottom
        leadingSpace.constant = edge.left
        trailingSpace.constant = edge.right
    }

    private func configureText(_ title: NSAttributedString) {
        self.titleLabel.attributedText = title
        setNeedsLayout()
    }
}
