//
//  UIViewController+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 25/10/2018.
//

import Foundation

public extension UIViewController {

    func kaoRefresher(action: Selector) -> UIRefreshControl {
        let position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: 30)
        let refreshControl = UIRefreshControl(frame: CGRect(origin: position, size: CGSize(width: 20, height: 20)))
        refreshControl.addTarget(self, action: action, for: .valueChanged)
        return refreshControl
    }
}
