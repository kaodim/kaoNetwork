//
//  KaoNotificationBanner.swift
//  KaoDesign
//
//  Created by augustius cokroe on 22/11/2018.
//

import Foundation
import NotificationBannerSwift

open class KaoNotificationBanner {

    public static let shared = KaoNotificationBanner()

    private var banner: NotificationBanner?

    public func dropNotification(_ type: KaoBannerType = .message, title: String? = nil, message: String?, bannerDelegate: NotificationBannerDelegate? = nil, on viewController: UIViewController? = nil, didTapView: (() -> Void)? = nil) {

        let notificationView = KaoNotificationBannerView()
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        let height = notificationView.configure(type, titleText: title, messageText: message)
        removeNotification()
        banner = NotificationBanner(customView: notificationView)
        notificationView.dismissTapped = { [weak self] in
            self?.banner?.dismiss()
        }
        let needExtraHeight = (viewController?.navigationController?.isNavigationBarHidden ?? true)
        banner?.bannerHeight =  needExtraHeight ? (height + 20) : height
        banner?.delegate = bannerDelegate
        banner?.dismissOnTap = false
        banner?.onTap = didTapView
        banner?.show(queuePosition: .front, bannerPosition: .top, on: viewController)
    }

    public func removeNotification() {
        banner?.removeFromSuperview()
    }
}
