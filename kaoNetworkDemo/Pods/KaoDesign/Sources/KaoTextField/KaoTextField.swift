//
//  KaoTextField.swift
//  KaoDesign
//
//  Created by Kelvin Tan on 7/17/19.
//

import UIKit

enum DescriptionState {
    case description, error
}

public class KaoTextField: UIView {

    @IBOutlet private weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var stackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var stackViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textFieldView: UIView!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var alertIcon: UIImageView!
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var dividerView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var iconButton: UIButton!

    public var handleTextChanged: ((_ text: String, _ index: Int) -> Void)?
    public var textBeginEditing: ((_ textField: UITextField) -> Void)?
    public var textEndEditing: ((_ textField: UITextField) -> Void)?
    public var textCharacterChange: ((_ textField: UITextField) -> Void)?
    public var reloadData: (() -> Void)?

    private var descriptionState: DescriptionState = .description

    private var contentView: UIView!

    // MARK: - init methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    // MARK: - Setup UI
    private func setupViews() {
        contentView = loadFromNib()
        contentView.frame = frame
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)
        setupUI()
    }

    private func setupUI() {
        textField.delegate = self
        textFieldView.addCornerRadius(4)
        clearError()
    }

    private func loadFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoTextField")
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Edges
    public func configureEdges(topConstraint: CGFloat, bottomConstraint: CGFloat, leadingConstraint: CGFloat, trailingConstraint: CGFloat) {
        stackViewTopConstraint.constant = topConstraint
        stackViewBottomConstraint.constant = bottomConstraint
        stackViewLeadingConstraint.constant = leadingConstraint
        stackViewTrailingConstraint.constant = trailingConstraint
    }

    // MARK: - Scenario
    public func configureErrorDescription(_ text: String) {
        configureTextFieldClear(.never)
        descriptionView.isHidden = false
        configureDescription(text, UIColor.kaoColor(.errorRed), 10)
        configureDividerColor(UIColor.kaoColor(.errorRed))
        alertIcon.image = UIImage.imageFromDesignIos("ic_formerror")
        alertIcon.tintColor = UIColor.kaoColor(.errorRed)
        alertIcon.isHidden = false
        descriptionState = .error
        //        configureTextFieldIcon("ic_formerror", color: UIColor.kaoColor(.errorRed))
    }

    public func clearError() {
        configureDividerColor(.lightGray)
        alertIcon.image = nil
        alertIcon.isHidden = true
        UIView.performWithoutAnimation {
            if self.descriptionState == .error {
                self.descriptionLabel.text = nil
                self.descriptionView.isHidden = true
            }
            reloadData?()
        }
    }

    private func configureTextFieldIcon( _ image: String = "ic_clearform", color: UIColor = UIColor.kaoColor(.alto)) {
        iconButton.tintColor = color
        iconButton.setImage(UIImage.imageFromDesignIos(image), for: .normal)
        iconButton.isHidden = false
    }

    @IBAction func clearText() {
        textField.text = ""
    }

    // MARK: Icon
    public func configureIcon(_ image: String? = nil, _ color: UIColor = .black, _ hide: Bool = true) {
        alertIcon.image = UIImage(named: image ?? "")
        alertIcon.tintColor = color
        alertIcon.isHidden = hide
    }

    // MARK: - Divider
    private func configureDividerColor(_ color: UIColor) {
        dividerView.backgroundColor = color
    }

    // MARK: - Description
    public func configureDescription(_ text: String? = nil, _ color: UIColor? = nil, _ constant: CGFloat = 0) {
        descriptionState = .description
        descriptionView.isHidden = text == nil
        descriptionLabel.textColor = color
        descriptionLabel.text = text
        descriptionLeadingConstraint.constant = constant
    }

    // MARK: - Title
    public func configureTitle(_ text: String, _ color: UIColor = UIColor.lightGray) {
        titleLabel.text = text
        titleLabel.textColor = color
    }

    public func floatTitle(_ color: UIColor = UIColor.kaoColor(.dustyGray2)) {
        titleLabel.font = titleLabel.font?.withSize(12)
        titleLabel.textColor = color
        titleLabelTopConstraint.constant = 5
        titleLabelLeadingConstraint.constant = 10
    }

    public func floatTitleChange(_ title: String) {
        floatTitle()
        titleLabel.text = title
    }

    open func unfloatTitle() {
        titleLabelTopConstraint.constant = 19
        titleLabelLeadingConstraint.constant = 10
        titleLabel.font = titleLabel.font?.withSize(16)
        titleLabel.textColor = UIColor.kaoColor(.greyishBrown)
        //        iconButton.isHidden = true
        //        iconButton = nil
    }

    // MARK: - Textfield
    open func configureTextField(_ text: String, _ color: UIColor = .black, _ enable: Bool = true) {
        textField.text = text
        textField.textColor = color
        textField.isEnabled = enable
    }

    public func configureTextFieldTag(_ row: Int) {
        textField.tag = row
    }

    public func setUserInteraction(_ enabled: Bool) {
        textField.isUserInteractionEnabled = enabled
    }

    public func configureTextFieldSecure(_ secure: Bool) {
        textField.isSecureTextEntry = secure
    }

    open func configureTextFieldClear(_ clearButton: UITextField.ViewMode) {
        textField.clearButtonMode = clearButton
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        handleTextChanged?(sender.text ?? "", sender.tag)
    }
}

extension KaoTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textCharacterChange?(textField)
        clearError()
        configureTextFieldClear(.whileEditing)
        return true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textBeginEditing?(textField)
        configureBeginAnimation()
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        textEndEditing?(textField)
        if textField.text?.isEmpty ?? false {
            configureEndAnimation()
        }
    }

    private func configureBeginAnimation() {
        floatTitle()
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
    }

    private func configureEndAnimation() {
        unfloatTitle()
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
    }

    private func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.transform = transform
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
