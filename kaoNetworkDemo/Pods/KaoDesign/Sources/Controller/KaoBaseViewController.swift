//
//  KaoBaseViewController.swift
//  Kaodim
//
//  Created by augustius cokroe on 13/11/2018.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

open class KaoBaseViewController: UIViewController, KaoNetworkProtocol {
    public var retry: (() -> Void)? = nil
    public var needListenToKeyboard: Bool = false
    public var hideTabbar: Bool = true

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        initialConfiguration()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfiguration()
    }

    private func initialConfiguration() {
        hidesBottomBarWhenPushed = hideTabbar
        navigationItem.backBarButtonItem = UIBarButtonItem.clearBackButton()
        navigationController?.navigationBar.kaodimStyle()
    }

    // MARK: - View cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needListenToKeyboard {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if needListenToKeyboard {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }

    // MARK: - Keyboard listener
    @objc open func keyboardWillShow(_ notification: Notification) { }

    @objc open func keyboardWillHide(_ notification: Notification) { }

    // MARK: - Layout animation
    public func animateLayout(duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - KaoNetworkProtocol
    open func addNetworkErrorView(_ errorView: UIView) {
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: safeTopAnchor),
            errorView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}
