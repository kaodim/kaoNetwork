//
//  UIColor+Extension.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 23/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//
// http://chir.ag/projects/name-that-color

import Foundation
import UIKit

public enum KaoColorHex: UInt {
    case linkWater = 0xE1EDF5
    case whiteLilac = 0xE6E7E8
    case whiteWildSand = 0xF4F4F4
    case chablis = 0xFFEFF1
    case bigStone = 0x12232E
    case midnight = 0x002340
    case prussianBlue = 0x003158
    case silver = 0xC0C0C0
    case curiousBlue = 0x3498DB
    case twilightBlue = 0xF8FFFF
    case altoSolid = 0xdbdbdb
    case alto = 0xD8D8D8
    case alto2 = 0xD9D9D9
    case dustyGray = 0x969696
    case dustyGray2 = 0x9b9b9b
    case hintOfGreen = 0xEBFFF3
    case azureRadiance = 0x007AFF
    case azureRadiance2 = 0x009FF8
    case opal = 0xA6BFBA
    case alabaster = 0xFAFAFA
    case sun = 0xFDB813
    case casper = 0xABC0CF
    case crimson = 0xE3193A
    case scorpion = 0x5A5A5A
    case mountainMeadow = 0x1ABC9C
    case aquaIsland = 0xA9D5DE
    case torchRed = 0xFF002A
    case vividBlue = 0x2692EE
    case cardinal = 0xC91634
    case shamRock = 0x2ECC71
    case jellyBean = 0x276F86
    case mercury = 0xE5E5E5
    case gableGreen = 0x13232E
    case dodgerBlue = 0x1E8CFF
    case flint = 0x707070
    case veryLightPink = 0xf2f2f2
    case scarlet = 0xd0021b
    case greyishBrown = 0x4a4a4a
    case black = 0x262626
    case brownishGrey = 0x636363
    case peacockBlue = 0x005e8d
    case whiteThree = 0xEEEEEE
    case boulder = 0x747474
    case mineShaft = 0x222222
    case bombay = 0xB6BAC2
    case oceanGreen = 0x4bb095
    case tradewind = 0x51ba9e
    case corn = 0xeac709
    case casablanca = 0xF9C647
    case cinnabar = 0xe3363b
    case carouselPink = 0xfbe8eb
    case malachite = 0x11b958
    case red = 0xfb0000
}

public extension UIColor {
    class func kaoColor(_ hex: KaoColorHex, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((hex.rawValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex.rawValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex.rawValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    func as1ptImage() -> UIImage? { // get line with color
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
