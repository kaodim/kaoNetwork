//
//  UIFont+Extension.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 23/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

public enum KaoFontSize: CGFloat {
    case xsmall = 10
    case small = 12
    case regular = 14
    case large = 16
    case title = 18
    case title1 = 20
    case title2 = 22
    case title3 = 24
    case title4 = 26
    case title5 = 28
}

public extension UIFont {

    class func kaoFont(style: UIFont.Weight, size: KaoFontSize) -> UIFont {
        let font = UIFont.systemFont(ofSize: size.rawValue, weight: style)
        return font

//        if let font = UIFont(name: style.rawValue, size: size.rawValue) {
//            return font
//        } else {
//            FontLoader.loadFont(style: style)
//            let font = UIFont(name: style.rawValue, size: size.rawValue)!
//            return font
//        }
    }
}

//private class FontLoader {
//    class func loadFont(style: KaoFontStyle) {
//        let bundle = Bundle(for: FontLoader.self)
//        let identifier = bundle.bundleIdentifier
//
//        var fontURL: URL
//        if identifier?.hasPrefix("org.cocoapods") == true {
//            // If this framework is added using CocoaPods, resources is placed under a subdirectory
//            fontURL = bundle.url(forResource: style.rawValue, withExtension: "ttf", subdirectory: "KaoCustomPod.bundle")!
//        } else {
//            fontURL = bundle.url(forResource: style.rawValue, withExtension: "ttf")!
//        }
//
//        guard
//            let data = try? Data(contentsOf: fontURL),
//            let provider = CGDataProvider(data: data as CFData),
//            let font = CGFont(provider)
//            else { return }
//
//        var error: Unmanaged<CFError>?
//        if !CTFontManagerRegisterGraphicsFont(font, &error) {
//            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
//            guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return }
//            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
//        }
//    }
//}
