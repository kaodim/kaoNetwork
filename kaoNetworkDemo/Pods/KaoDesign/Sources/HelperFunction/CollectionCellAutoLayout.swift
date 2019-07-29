//
//  CollectionCellAutoLayout.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

public protocol CollectionCellAutoLayout: class {
    var cachedSize: CGSize? { get set }
}

public extension CollectionCellAutoLayout where Self: UICollectionViewCell {

    // call me in preferredLayoutAttributesFitting
    func preferredLayoutAttributes(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

//        if let cachedSize = cachedSize, cachedSize.equalTo(layoutAttributes.size) {
//            return layoutAttributes
//        }
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        cachedSize = newFrame.size
        return layoutAttributes
    }
}
