//
//  UIImageView+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 24/10/2018.
//

import Foundation
import Kingfisher

public extension UIImageView {
    func cache(withURL url: String, placeholder: UIImage? = nil, completion: ((_ image: UIImage?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> Void)? = nil) {

        /// 50 MB, default is no limit.
        ImageCache.default.maxDiskCacheSize = 50 * 1024 * 1024
        /// Period of cache, which means 1 week.
        ImageCache.default.maxCachePeriodInSecond = 60 * 60 * 24 * 3

        let options: KingfisherOptionsInfo = [.transition(.fade(0.5))]

        self.kf.setImage(
            with: URL(string: url),
            placeholder: placeholder,
            options: options,
            progressBlock: nil)
        { (image, error, cacheType, url) in
            completion?(image, error, cacheType, url)
        }
    }
}
