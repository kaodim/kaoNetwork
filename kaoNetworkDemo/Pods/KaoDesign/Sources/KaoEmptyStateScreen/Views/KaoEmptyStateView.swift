//
//  KaoEmptyStateView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

public struct KaoEmptyState {
    public var icon: UIImage?
    public var title: NSAttributedString?
    public var message: NSAttributedString?
    public var buttonTitle: String?
    public var topSpace: CGFloat
    public var iconSpace: CGFloat
    public var buttonSpace: CGFloat
    public var buttonDidTapped: (() -> Void)?

    public init
        (icon: UIImage? = nil, title: NSAttributedString? = nil, message: NSAttributedString? = nil, buttonTitle: String? = nil, topSpace: CGFloat = 20, iconSpace: CGFloat = 24, buttonSpace: CGFloat = 16, buttonDidTapped: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.topSpace = topSpace
        self.iconSpace = iconSpace
        self.buttonSpace = buttonSpace
        self.buttonDidTapped = buttonDidTapped
    }
}

public class KaoEmptyStateView: UIView {

    @IBOutlet private weak var iconContentView: UIView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var iconBottomSpace: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var messageLabel: KaoLabel!
    @IBOutlet private weak var buttonContentView: UIView!
    @IBOutlet private weak var buttonTopSpace: NSLayoutConstraint!
    @IBOutlet private weak var button: KaoButton!

    private var contentView: UIView!
    private var emptyStateData: KaoEmptyState?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoEmptyStateView")
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
        titleLabel.font = UIFont.kaoFont(style: .medium, size: .large)
        messageLabel.font = UIFont.kaoFont(style: .regular, size: .regular)
    }

    public func configure(_ data: KaoEmptyState) {
        self.emptyStateData = data
        topConstraint.constant = data.topSpace
        configureIcon(data)
        configureTitle(data)
        configureMessage(data)
        configureButton(data)
    }

    private func configureIcon(_ data: KaoEmptyState) {
        if let sicon = data.icon {
            iconBottomSpace.constant = data.iconSpace
            iconContentView.isHidden = false
            icon.image = sicon
        } else {
            iconContentView.isHidden = true
        }
    }

    private func configureTitle(_ data: KaoEmptyState) {
        if let stitle = data.title {
            titleLabel.isHidden = false
            titleLabel.attributedText = stitle
        } else {
            titleLabel.isHidden = true
        }
    }

    private func configureMessage(_ data: KaoEmptyState) {
        if let smessage = data.message {
            messageLabel.isHidden = false
            messageLabel.attributedText = smessage
        } else {
            messageLabel.isHidden = true
        }
    }

    private func configureButton(_ data: KaoEmptyState) {
        if let sbutton = data.buttonTitle {
            buttonTopSpace.constant = data.buttonSpace
            buttonContentView.isHidden = false
            button.setTitle(sbutton, for: .normal)
        } else {
            buttonContentView.isHidden = true
        }
    }

    @IBAction private func buttonDidTapped() {
        emptyStateData?.buttonDidTapped?()
    }
}
