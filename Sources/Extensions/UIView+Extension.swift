//
//  UIView+Extension.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/11/19.
//

import Foundation

public extension UIView {
    class func nibFromKaoNetwork(_ fileName: String) -> UINib {
        return NibLoader.loadNib(fileName: fileName)
    }
}

private class NibLoader {
    class func loadNib(fileName: String) -> UINib {
        let nib:UINib!
        let podBundle = Bundle(for: NibLoader.self)
        if let bundleURL = podBundle.url(forResource: "KaoNetworkCustomPod", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            nib = UINib(nibName: fileName, bundle: bundle)
        } else {
            nib = UINib(nibName: fileName, bundle: Bundle.main)
        }
        return nib
    }
}
