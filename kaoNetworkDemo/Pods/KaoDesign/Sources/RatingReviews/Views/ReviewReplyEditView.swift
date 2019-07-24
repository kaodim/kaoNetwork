//
//  ReviewReplyEditView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

class ReviewReplyEditView: UIView {

    @IBOutlet private weak var replyTo: KaoLabel!
    @IBOutlet private weak var username: KaoLabel!
    @IBOutlet private weak var textViewContainer: UIView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var cancelButton: KaoButton!
    @IBOutlet private weak var sendButton: KaoButton!

    private var contentView: UIView!
    private var previousText: String = ""
    private var placeholder: String = ""

    var cancelTapped: (() -> Void)?
    var sendTapped: ((_ text: String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("ReviewReplyEditView")
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

        replyTo.font = UIFont.kaoFont(style: .regular, size: 16)
        username.font = UIFont.kaoFont(style: .semibold, size: 16)
        textViewContainer.addCornerRadius()
        textViewContainer.addBorderLine(width: 1, color: .kaoColor(.dustyGray2))
        textView.delegate = self
        cancelButton.configure(type: .dismiss)
    }

    private func handleTextInput(_ text: String = "") {
        if !text.isEmpty {
            textView.removePlaceholder()
        } else {
            textView.addPlaceholderText(placeholder)
        }

        let textChanged = previousText != text || previousText.isEmpty
        sendButton.isEnabled = textChanged && !text.isEmpty

        var textFrame = textView.frame
        textFrame.size.height = textView.contentSize.height
        textView.frame = textFrame
        self.superview?.needsUpdateConstraints()
    }

    private func configureSharedLocalization(_ localization: RatingReviewLocalization) {
        placeholder = localization.translate(.typeAMessage)
        cancelButton.setTitle(localization.translate(.cancel), for: .normal)
    }

    public func configureForReply(_ review: Review, localization: RatingReviewLocalization) {
        configureSharedLocalization(localization)
        sendButton.setTitle(localization.translate(.send), for: .normal)
        replyTo.text = localization.translate(.replyingTo)
        username.text = review.name
        handleTextInput()
    }

    public func configureForEdit(_ review: Review, localization: RatingReviewLocalization) {
        configureSharedLocalization(localization)
        previousText = review.reply?.comment ?? ""
        sendButton.setTitle(localization.translate(.update), for: .normal)
        replyTo.text = localization.translate(.editYourComment)
        username.text = ""
        textView.text = review.reply?.comment ?? ""
        handleTextInput(textView.text)
    }

    public func startKeyboard() {
        textView.becomeFirstResponder()
    }

    public func endKeyboard() {
        textView.resignFirstResponder()
    }

    // MARK: - IBAction method
    @IBAction private func cancelTap() {
        cancelTapped?()
    }

    @IBAction private func sendTap() {
        sendTapped?(textView.text)
    }
}

// MARK: - UITextViewDelegate
extension ReviewReplyEditView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        handleTextInput(textView.text)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 {
            return text != " " && text != "\n"
        }
        return true
    }

}
