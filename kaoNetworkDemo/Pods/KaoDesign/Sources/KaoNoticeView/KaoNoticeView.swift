//
//  KaoNoticeView.swift
//  KaoDesign
//
//  Created by Augustius on 27/05/2019.
//

import Foundation

public enum KaoNoticeViewCase: String {
    case info = "ic_info_blue", warning = "ic_cancel_warnings", error = "icon_error", waiting = "icon_waiting"
}

public class KaoNoticeView: UIView {

    @IBOutlet private weak var cardViewTrailing: NSLayoutConstraint!
    @IBOutlet private weak var cardViewLeading: NSLayoutConstraint!
    @IBOutlet private weak var cardViewTop: NSLayoutConstraint!
    @IBOutlet private weak var cardViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var messageLabel: KaoLabel!
    @IBOutlet private weak var cardButton: KaoButton!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: KaoLabel!

    private var contentView: UIView!
    public var cardViewTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
    
    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoNoticeView")
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
        needsUpdateConstraints()
    }

    private func configureViews() {
        contentView = loadFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        
        cardView.addCornerRadius()
        messageLabel.font = UIFont.kaoFont(style: .regular, size: 15)
        cardButton.isHidden = true
        titleView.isHidden = true
    }
    
    public func configureEdge(_ edge: UIEdgeInsets) {
        cardViewTop.constant = edge.top
        cardViewBottom.constant = edge.bottom
        cardViewLeading.constant = edge.left
        cardViewTrailing.constant = edge.right
    }
    
    public func configure(_ message: String) {
        configureAttr(message.attributeString())
    }
    
    public func configureAttr(_ attrMessage: NSAttributedString) {
        messageLabel.attributedText = attrMessage
        setNeedsLayout()
    }

    public func configureIcon(_ iconCase: KaoNoticeViewCase) {
        icon.image = UIImage.imageFromDesignIos(iconCase.rawValue)
        switch iconCase {
        case .info:
            cardView.backgroundColor = .kaoColor(.hawkesBlue)
        case .warning:
            cardView.backgroundColor = .kaoColor(.kaodimOrange, alpha: 0.2)
        case .error:
            cardView.backgroundColor = .kaoColor(.warningRed)
        case .waiting:
            cardView.backgroundColor = .kaoColor(.kaodimOrange20)
        }
    }

    public func configureTitle(_ text: String) {
        titleLabel.text = text
        titleView.isHidden = false
    }

    public func configureButton(_ text: String) {
        cardButton.setTitle(text, for: .normal)
        cardButton.isHidden = false
    }

    @IBAction private func cardViewTapped() {
        cardViewTap?()
    }
}
