//
//  ReviewListReplyViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

class ReviewListReplyViewController: KaoBaseViewController {

    lazy var editContainer: ReviewReplyEditView = {
        let view = ReviewReplyEditView()
        view.sendTapped = sendTap
        view.cancelTapped = cancelTap
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.kaoColor(.black, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelTap)))
        return view
    }()

    var review: Review!
    var localization: RatingReviewLocalization!
    private var bottomConstraint: NSLayoutConstraint!

    var sendTapped: ((_ text: String) -> Void)?
    var editViewDidDismiss: (() -> Void)?

    init(_ review: Review, localization: RatingReviewLocalization) {
        super.init(nibName: nil, bundle: nil)
        self.review = review
        self.localization = localization
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.needListenToKeyboard = true
        super.viewDidLoad()
        configureLayout()
        configureEditContainer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }

    private func startAnimation() {
        blurView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.blurView.alpha = 1
                self.editContainer.startKeyboard()
                self.view.layoutIfNeeded()
            })
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        editContainer.endKeyboard()
        editViewDidDismiss?()
    }

    private func configureLayout() {
        view.backgroundColor = .clear
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: safeTopAnchor, constant: -150),
            blurView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])

        view.addSubview(editContainer)
        bottomConstraint = editContainer.bottomAnchor.constraint(equalTo: safeBottomAnchor)
        NSLayoutConstraint.activate([
            bottomConstraint,
            editContainer.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            editContainer.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }

    func configureEditContainer() {
        editContainer.configureForReply(review, localization: localization)
    }

    // MARK: - Callback
    private func sendTap(_ text: String) {
        self.sendTapped?(text)
    }

    @objc private func cancelTap() {
        dismiss(animated: false, completion: nil)
    }

    // MARK: - Keyboard
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            bottomConstraint.constant = -keyboardHeight
        }
    }

    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        bottomConstraint.constant = 0
    }
}

extension UIViewController {

    func presentReviewListReplyVC(_ review: Review, localization: RatingReviewLocalization, sendTapped: ((_ text: String) -> Void)?, viewDidDismiss: (() -> Void)?) {
        let view = ReviewListReplyViewController(review, localization: localization)
        view.sendTapped = sendTapped
        view.editViewDidDismiss = viewDidDismiss
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: false, completion: nil)
    }
}

