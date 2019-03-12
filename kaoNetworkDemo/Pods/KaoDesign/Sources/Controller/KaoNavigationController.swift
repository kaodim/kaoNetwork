//
//  KaoNavigationController.swift
//  Kaodim Pro
//
//  Created by augustius cokroe on 16/11/2018.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

open class KaoNavigationController: UINavigationController {

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationBar()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureNavigationBar()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureNavigationBar()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureNavigationBar() {
        /// Navigation bar content
        navigationBar.kaodimStyle()
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem.clearBackButton()
    }
}
