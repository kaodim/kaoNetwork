//
//  KaoSpinningView.swift
//  TestTAbleView
//
//  Created by Ramkrishna Baddi on 20/12/18.
//  Copyright © 2018 Ramkrishna Baddi. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
@objcMembers
open class KaoSpinningView: UIView {

    // MARK: Properties
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()

    /// Line width of spinner
    @IBInspectable open var lineWidth: CGFloat = 4 {
        didSet {
            circleLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    /// Set animation to enable/disable animation
    @IBInspectable open var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }

    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]

        return group
    }()

    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.75
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]

        return group
    }()

    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
        return animation
    }()

    // MARK: Private variables
    private lazy var checkMarkLayer: CAShapeLayer = {
        return self.createCheckmarkLayer(strokeColor: self.tintColor, strokeEnd: 1)
    }()
    private var animatedLayer: CAShapeLayer?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    override open func tintColorDidChange() {
        super.tintColorDidChange()
        circleLayer.strokeColor = tintColor.cgColor
    }

    private func setup() {
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = nil
        circleLayer.strokeColor = tintColor.cgColor

        maskLayer.lineWidth = lineWidth
        maskLayer.fillColor = nil
        maskLayer.strokeColor = tintColor.withAlphaComponent(0.2).cgColor
        layer.addSublayer(maskLayer)
        layer.addSublayer(circleLayer)
        tintColorDidChange()
    }

    func updateAnimation() {
        if animating {
            circleLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            circleLayer.add(strokeStartAnimation, forKey: "strokeStart")
            circleLayer.add(rotationAnimation, forKey: "rotation")
        }
        else {
            circleLayer.removeAnimation(forKey: "strokeEnd")
            circleLayer.removeAnimation(forKey: "strokeStart")
            circleLayer.removeAnimation(forKey: "rotation")
        }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2

        let startAngle = -(Double.pi / 2)
        let endAngle =  startAngle + Double.pi * 2

        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)

        circleLayer.position = center
        circleLayer.path = path.cgPath

        maskLayer.position = center
        maskLayer.path = path.cgPath

    }
}

// MARK: - Check mark layer
extension KaoSpinningView {

    public func animate(duration: TimeInterval = 0.6) {
        guard let animatedLayer = animatedLayer else { return }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animatedLayer.strokeEnd = 1
        animatedLayer.add(animation, forKey: "animateCheckmark")
    }
    // MARK: Private methods
    private func configureView() {
        backgroundColor = UIColor.clear
        layer.addSublayer(checkMarkLayer)
    }

    private func createCheckmarkLayer(strokeColor: UIColor, strokeEnd: CGFloat) -> CAShapeLayer {
        let scale = frame.width / 100
        let centerX = frame.size.width / 2
        let centerY = frame.size.height / 2
        let checkmarkPath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: centerX, startAngle:  0, endAngle: 0, clockwise: true)
        checkmarkPath.move(to: CGPoint(x: centerX - 18 * scale, y: centerY - 1 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX - 6 * scale, y: centerY + 15.9 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX + 22.8 * scale, y: centerY - 23.4 * scale))
        let checkmarkLayer = CAShapeLayer()
        checkmarkLayer.fillColor = UIColor.clear.cgColor
        checkmarkLayer.lineWidth = lineWidth
        checkmarkLayer.path = checkmarkPath.cgPath
        checkmarkLayer.strokeEnd = strokeEnd
        checkmarkLayer.strokeColor = strokeColor.cgColor
        checkmarkLayer.lineCap = kCALineCapRound
        checkmarkLayer.lineJoin = kCALineJoinRound
        return checkmarkLayer
    }

    private func showAnimatedCheckMark() {
        if animating {
            animatedLayer = createCheckmarkLayer(strokeColor: tintColor, strokeEnd: 0)
            layer.addSublayer(animatedLayer!)
            self.animate(duration: 0.3)
        } else {
            configureView()
        }
    }
}

// MARK: - Helpers to show/ Hide spinner view
extension KaoSpinningView {

    /// Show spinner
    open func show(_ duration: Double = 0.33) {
        self.hide {
            self.alpha = 0
            self.animating = true
            self.updateAnimation()
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                self.alpha = 1
                self.layer.addSublayer(self.maskLayer)
                self.layer.addSublayer(self.circleLayer)
            }, completion: nil)
        }
    }

    /// hide spinner
    open func hide(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async(execute: {
            self.animating = false
            self.updateAnimation()
            UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.alpha = 1
                self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                completion?()
            })
        })
    }

    /// Show check mark
    open func showSuccess() {
        self.hide {
            self.animating = true
            self.showAnimatedCheckMark()
        }
    }
}

