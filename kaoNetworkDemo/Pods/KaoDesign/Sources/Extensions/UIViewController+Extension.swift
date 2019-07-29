//
//  UIViewController+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 25/10/2018.
//

import Foundation

public extension UIViewController {

    // MARK: - Navigation Item
    // call below function on init
    func configureRightBarItem(_ icon: UIImage? = UIImage(named:"ic_close_white")) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(dismissViewController))
    }

    func configureRightBarItem(_ title: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(dismissViewController))
    }

    @objc func dismissViewController() {
        if let view = self as? KaoBaseViewController {
            view.rightBarTapped()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func mostTopOffset() -> CGFloat {
        let navHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let statusHeight = UIApplication.shared.statusBarView?.frame.height ?? 0
        return navHeight + statusHeight
    }

    // MARK: - Component
    func kaoRefresher(action: Selector) -> UIRefreshControl {
        let position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: 30)
        let refreshControl = UIRefreshControl(frame: CGRect(origin: position, size: CGSize(width: 20, height: 20)))
        refreshControl.addTarget(self, action: action, for: .valueChanged)
        return refreshControl
    }
}
