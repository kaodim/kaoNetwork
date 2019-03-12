//
//  KaoTextInputCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 14/02/2019.
//

import Foundation

public class KaoTextInputCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textViewBorderView: UIView!
    @IBOutlet weak var textViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var textViewLeading: NSLayoutConstraint!
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!

    public var textDidChange: ((_ text: String?) -> Void)?
    public var titleText: String? = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    public var placeHolder: String = "" {
        didSet {
            textView.addPlaceholderText(placeHolder)
        }
    }
    public var isTextEmpty: Bool {
        return (textView.text?.isEmpty) ?? true
    }
    public var value: String {
        return textView.text ?? ""
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = UIFont.kaoFont(style: .regular, size: .small)
        textView.font = UIFont.kaoFont(style: .regular, size: .regular)
        textView.keyboardType = .default
        textView.delegate = self
        textViewBorderView.backgroundColor = UIColor.kaoColor(.whiteLilac)
    }

    public func setOnFocusField() {
        textView.becomeFirstResponder()
    }

    public func resetTextViewValue() {
        textView.text = nil
    }

    public func populate(with text: String?) {
        if text != nil {
            textView.removePlaceholder()
            textView.text = text
        }
    }

    private func updateCellFrame(_ newHeight: CGFloat) {
        let targetHeight = newHeight + 20.0
        if  targetHeight >= bounds.height {
            (superview as? UITableView)?.beginUpdates()
            (superview as? UITableView)?.endUpdates()
        }
    }

    // MARK: - UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text, text != "" {
            textView.removePlaceholder()
            textDidChange?(textView.text)
        } else {
            textView.addPlaceholderText(placeHolder)
            textDidChange?(nil)
        }
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 {
            return text != " " && text != "\n"
        }

        var textFrame = textView.frame
        textFrame.size.height = textView.contentSize.height + 10.0
        textView.frame = textFrame
        updateCellFrame(textFrame.size.height)
        return true
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        textViewBorderView.backgroundColor = UIColor.kaoColor(.bigStone)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        textViewBorderView.backgroundColor = UIColor.kaoColor(.whiteLilac)
    }

    public func configureEdge(_ edge: UIEdgeInsets) {
        titleTop.constant = edge.top
        textViewBottom.constant = edge.bottom
        textViewLeading.constant = edge.left
        textViewTrailing.constant = edge.right
    }
}
