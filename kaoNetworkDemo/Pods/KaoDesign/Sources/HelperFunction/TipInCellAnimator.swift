//
//  TipInCellAnimator.swift
//  KaoDesign
//
//  Created by augustius cokroe on 22/04/2019.
//

import Foundation

public let tipInCellAnimatorStartTransform: CATransform3D = {
    let offset = CGPoint(x: 0, y: 150)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    return startTransform
}()

public class TipInCellAnimator {

    public class func animate(cell: UITableViewCell, transform: CATransform3D = tipInCellAnimatorStartTransform) {
        let view = cell.contentView
        view.layer.transform = transform
        view.layer.opacity = 0
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }

    public class func animate(view: UIView, transform: CATransform3D = tipInCellAnimatorStartTransform) {
        view.layer.transform = transform
        view.layer.opacity = 0
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }

    public class func animate(view: UIView, from: CATransform3D, to: CATransform3D, completion: (() -> Void)? = nil) {
        view.layer.transform = from
        view.layer.opacity = 0
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = to
            view.layer.opacity = 1
            completion?()
        }
    }
}
