//
//  KaoBottomButtonView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 11/02/2019.
//

import Foundation

public class KaoBottomButtonView: UIView {

    @IBOutlet private weak var button: KaoButton!

    public var enableButton: Bool = true {
        didSet {
            button.isEnabled = enableButton
        }
    }
    public var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    private var contentView: UIView!
    public var buttonDidTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoBottomButtonView")
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
    }

    @IBAction private func buttonPressed() {
        buttonDidTapped?()
    }
}
