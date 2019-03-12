//
//  KaoSettingPermissionViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 01/03/2019.
//

import Foundation

public class KaoSettingPermissionViewController: KaoPresenterViewController {

    private lazy var popView: KaoPopupView = {
        let view = KaoPopupView()
        let settingButton = KaoPopupAction(title: buttonText, style: .primary)
        let cancelButton = KaoPopupAction(title: cancelText, style: .dismiss)
        view.configure(UIImage.imageFromDesignIos("img_gotosettings"), messageText: messageText, firstKaoButton: cancelButton, secondKaoButton: settingButton)
        view.firstButtonTapped = { self.dismissAnimation() }
        view.secondButtonTapped = openSettingsScreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var messageText: NSAttributedString!
    private var buttonText: String!
    private var cancelText: String!
    private var firstKaoButton: KaoPopupAction?
    private var secondKaoButton: KaoPopupAction?

    public convenience init(_ message: String, buttonText: String, cancelText: String) {
        self.init(NSAttributedString(string: message), buttonText: buttonText, cancelText: cancelText)
    }

    public init(_ message: NSAttributedString, buttonText: String, cancelText: String) {
        super.init(nibName: nil, bundle: nil)
        self.messageText = message
        self.buttonText = buttonText
        self.cancelText = cancelText
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.presentView = popView
        super.viewDidLoad()
    }

    private func openSettingsScreen() {
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
