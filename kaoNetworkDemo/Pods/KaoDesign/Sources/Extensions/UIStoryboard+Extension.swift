//
//  UIStoryboard+Extension.swift
//  KaoDesign
//
//  Created by Ramkrishna Baddi on 12/12/18.
//

import Foundation

public extension UIStoryboard {
    class func StoryboardFromDesignIos(_ fileName: String) -> UIStoryboard {
        return StoryboardLoader.loadStoryboard(fileName: fileName)
    }
}

private class StoryboardLoader {
    class func loadStoryboard(fileName: String) -> UIStoryboard {
        let storyboard:UIStoryboard!
        let podBundle = Bundle(for: StoryboardLoader.self)
        if let bundleURL = podBundle.url(forResource: "KaoCustomPod", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            storyboard = UIStoryboard.init(name: fileName, bundle: bundle)
        } else {
            storyboard = UIStoryboard.init(name: fileName, bundle: Bundle.main)
        }
        return storyboard
    }
}
