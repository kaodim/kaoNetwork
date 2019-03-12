//
//  UIImage+Extension.swift
//  KaoDesignIos
//
//  Created by augustius cokroe on 23/10/2018.
//

import Foundation
import FontAwesome_swift

public enum QualityType: CGFloat {
    case lowest  = 0
    case low     = 0.25
    case medium  = 0.5
    case high    = 0.75
    case highest = 1
}

public extension UIImage {
    class func imageFromDesignIos(_ imageName: String) -> UIImage? {
        return ImageLoader.loadImage(imageName: imageName)
    }

    class func icon(_ type: FontAwesome, color: UIColor = .white, size: CGSize = CGSize(width: 30.0, height: 30.0)) -> UIImage {
        return UIImage.fontAwesomeIcon(name: type, textColor: color, size: size)
    }

    public func resizeImage(targetHeight: CGFloat) -> UIImage? {
        let size = self.size
        let targetWidth = targetHeight * ( size.width / size.height )
        let newSize = CGSize(width: targetWidth, height: targetHeight)
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    public func compressedImage(_ quality: QualityType) -> UIImage? {
        if let data = UIImageJPEGRepresentation(self, quality.rawValue) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }

    public func compressedData(_ quality: QualityType) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}

private class ImageLoader {
    class func loadImage(imageName: String) -> UIImage? {
        let podBundle = Bundle(for: ImageLoader.self)
        let bundleURL = podBundle.url(forResource: "KaoCustomPod", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        return image
    }
}
