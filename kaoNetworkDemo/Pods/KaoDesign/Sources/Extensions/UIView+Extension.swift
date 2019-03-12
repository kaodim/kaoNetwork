//
//  UIView+Extension.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 23/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func addBorderLine(width: CGFloat = 1, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func makeRoundCorner() {
        addCornerRadius(self.frame.size.height / 2)
        self.clipsToBounds = true
    }

    func makeDashBorder() {
        let dashBorder = CAShapeLayer()
        dashBorder.strokeColor = UIColor.kaoColor(.silver).cgColor
        dashBorder.lineDashPattern = [2, 2]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
        layer.addSublayer(dashBorder)
        layer.masksToBounds = true
    }

    class func kaoTableHeaderView(_ title: String, width: CGFloat) -> UIView {
        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 40)))
        headerView.backgroundColor = .clear

        let label = UILabel(frame: CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: width - 20, height: 20)))
        label.textColor = .kaoColor(.dustyGray)
        label.font = .kaoFont(style: .medium, size: .regular)
        label.text = title
        headerView.addSubview(label)
        return headerView
    }

    func dropShadow(shadowRadius radius: CGFloat? = 2.0, shadowColor: UIColor = UIColor.gray, shadowPath: CGPath? = nil, shadowOffSet: CGSize = CGSize(width: 0.0, height: 1.0), shadowOpacity: Float = 0.8) {
        layer.cornerRadius = 4
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity

        layer.shadowRadius = (radius ?? 2.0 - 1.0)
        layer.masksToBounds = false
        layer.shadowPath = shadowPath
        layer.borderColor = shadowColor.cgColor
        clipsToBounds = false
    }

    class func nibFromDesignIos(_ fileName: String) -> UINib {
        return NibLoader.loadNib(fileName: fileName)
    }
}

private class NibLoader {
    class func loadNib(fileName: String) -> UINib {
        let nib:UINib!
        let podBundle = Bundle(for: NibLoader.self)
        if let bundleURL = podBundle.url(forResource: "KaoCustomPod", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            nib = UINib(nibName: fileName, bundle: bundle)
        } else {
            nib = UINib(nibName: fileName, bundle: Bundle.main)
        }
        return nib
    }

    
}
