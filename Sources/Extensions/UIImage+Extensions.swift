//
//  UIImage+Extension.swift
//  KaoDesign
//
//  Created by Kelvin Tan on 3/12/19.
//

import Foundation


public extension UIImage {
    class func imageFromNetworkIos(_ imageName: String) -> UIImage? {
        return ImageLoader.loadImage(imageName: imageName)
    }
}

private class ImageLoader {
    class func loadImage(imageName: String) -> UIImage? {
        let podBundle = Bundle(for: ImageLoader.self)
        let bundleURL = podBundle.url(forResource: "KaoNetworkCustomPod", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        return image
    }
}
