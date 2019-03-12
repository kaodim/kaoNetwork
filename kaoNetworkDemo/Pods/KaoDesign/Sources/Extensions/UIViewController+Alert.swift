//
//  UIViewController+Alert.swift
//  KaoDesign
//
//  Created by augustius cokroe on 09/11/2018.
//

import Foundation

public extension UIViewController {
    func dropErrorMessage(_ message: String) {
        KaoNotificationBanner.shared.dropNotification(.error, message: message, on: self)
    }

    func dropSuccessMessage(_ message: String) {
        KaoNotificationBanner.shared.dropNotification(.success, message: message, on: self)
    }
}
