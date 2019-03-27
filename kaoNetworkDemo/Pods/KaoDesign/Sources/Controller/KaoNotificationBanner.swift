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
        var height = notificationView.configure(type, titleText: title, messageText: message)
        removeNotification()
        banner = NotificationBanner(customView: notificationView)
        notificationView.dismissTapped = { [weak self] in
            self?.banner?.dismiss()
        }

        height += getExtraHeight(viewController)
        banner?.bannerHeight = height
        banner?.delegate = bannerDelegate
        banner?.dismissOnTap = false
        banner?.onTap = didTapView
        banner?.show(queuePosition: .front, bannerPosition: .top, on: viewController)
    }

    public func removeNotification() {
        banner?.removeFromSuperview()
    }

    private func getExtraHeight(_ viewController: UIViewController?) -> CGFloat {
        let hasNavigation = (viewController?.navigationController?.isNavigationBarHidden ?? true)
        let notchHeight: CGFloat = (isiPhoneX() && hasNavigation) ? 24 : 0
        let navigationHeight: CGFloat = hasNavigation ? 20 : 0
        let extraHeight = notchHeight + navigationHeight
        return extraHeight
    }

    private func isiPhoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom != .phone {
            return false
        }
        
        switch UIDevice.modelName {
        case "iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR":
            return true
        default:
            return false
        }
    }
}
