//
//  ReviewListHeaderView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

class ReviewListHeaderView: UIView {

    @IBOutlet private weak var reviewTitle: KaoLabel!
    @IBOutlet private weak var reviewDesc: KaoLabel!

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
        let nib = UIView.nibFromDesignIos("ReviewListHeaderView")
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
        reviewTitle.font = UIFont.kaoFont(style: .bold, size: 18)
        reviewDesc.font = UIFont.kaoFont(style: .regular, size: 14)
    }

    public func configure(_ title: String, desc: String) {
        reviewTitle.text = title
        reviewDesc.text = desc
    }
}
