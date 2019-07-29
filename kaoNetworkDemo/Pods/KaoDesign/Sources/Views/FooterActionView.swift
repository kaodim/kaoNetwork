//
//  FooterActionView.swift
//  Pods
//
//  Created by Ramkrishna on 28/05/2019.
//

import UIKit

public class FooterActionView: UIView {

    @IBOutlet private weak var cardLeading: NSLayoutConstraint!
    @IBOutlet private weak var cardTrailing: NSLayoutConstraint!
    @IBOutlet private weak var cardTop: NSLayoutConstraint!
    @IBOutlet private weak var cardBottom: NSLayoutConstraint!
    @IBOutlet private weak var titleTextView: UITextView!
    @IBOutlet private weak var button: UIButton!

    private var contentView: UIView!
    public var buttonTapped: (() -> Void)?
    public var linkTapped: ((_ URL: URL) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("FooterActionView")
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
        button.setTitleColor(UIColor.kaoColor(.vividBlue), for: .normal)
    }

    // MARK: - Public methods
    public func configure(edge: UIEdgeInsets) {
        cardTop.constant = edge.top
        cardBottom.constant = edge.bottom
        cardLeading.constant = edge.left
        cardTrailing.constant = edge.right
    }

    public func configure(_ title: NSAttributedString?, _ buttonTitle: String?) {
        configureText(title)
        configureButton(buttonTitle)
    }

    public func configure(_ title: String?, buttonTitle: String?) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        configureText(NSAttributedString.init(string: title ?? "", attributes: [
            NSAttributedStringKey.font: UIFont.kaoFont(style: .regular, size: 15.0),
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.paragraphStyle : paragraph]))
        configureButton(buttonTitle)
    }

    public func configureLinkWithAttributes(_ title: NSAttributedString, linkAttributes: [String : Any] = [:] , _ buttonTitle: String?) {
        configureText(title)
        configureButton(buttonTitle)
        titleTextView.linkTextAttributes = linkAttributes
        titleTextView.delegate = self
    }

    public func configureButtonStyle(_ font: UIFont, icon: UIImage? = nil, iconPosition: UISemanticContentAttribute = .forceLeftToRight) {
        button.titleLabel?.font = font
        button.setImage(icon, for: .normal)
        button.semanticContentAttribute = iconPosition
    }

    private func configureText(_ title: NSAttributedString?) {
        if let title = title, !title.string.isEmpty {
            self.titleTextView.attributedText = title
        } else {
            titleTextView.isHidden = true
        }
        setNeedsLayout()
    }

    private func configureButton(_ title: String?) {
        if let title = title {
            button.setTitle(title, for: .normal)
        } else {
            button.isHidden = true
        }
    }

    @IBAction func buttonAction(_ sender: Any) {
        self.buttonTapped?()
    }
}


extension FooterActionView : UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        self.linkTapped?(URL)
        return false
    }
}
