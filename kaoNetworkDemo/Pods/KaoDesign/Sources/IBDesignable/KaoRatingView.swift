//
//  KaoRatingView.swift
//  RatingComponent
//
//  Created by Ramkrishna Baddi on 17/12/18.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol FloatRatingViewDelegate {
    /// Returns the rating value when touch events end
    @objc optional func floatRatingView(_ ratingView: KaoRatingView, didUpdate rating: Double)

    /// Returns the rating value as the user pans
    @objc optional func floatRatingView(_ ratingView: KaoRatingView, isUpdating rating: Double)
}


///
@IBDesignable
@objcMembers
open class KaoRatingView: UIView {

    // MARK: Properties


    open weak var delegate: FloatRatingViewDelegate?


    /// Array of empty image views

    var emptyStarViews: [UIImageView] = []

    /// Array of full images views

    var fullStarViews: [UIImageView] = []

    /// Set the empty image (eg: A start outline )
    @IBInspectable open var emptyStarImage: UIImage? {
        didSet {
            for imageView in emptyStarViews {
                imageView.image = emptyStarImage
            }
            refresh()
        }
    }

    /// Sets the full image that is overlayed on top of the empty image.
    /// Should be same size and shape as the empty image.
    @IBInspectable open var fullStarImage: UIImage? {
        didSet {
            for imageView in fullStarViews {
                imageView.image = fullStarImage
            }
            refresh()
        }
    }

    /// Sets the empty and full image view content mode.
    open var imageContentMode: UIView.ContentMode = UIView.ContentMode.scaleAspectFit

    /// Minimum rating.
    @IBInspectable open var minRating: Int  = 0 {
        didSet {
            // Update current rating if needed
            if rating < Double(minRating) {
                rating = Double(minRating)
                refresh()
            }
        }
    }

    /// Max rating value.
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            if maxRating != oldValue {
                removeImageViews()
                initImageViews()

                // Relayout and refresh
                setNeedsLayout()
                refresh()
            }
        }
    }

    /// Minimum image size.
    @IBInspectable open var minImageSize: CGSize = CGSize(width: 5.0, height: 5.0)

    /// Set the current rating.
    @IBInspectable open var rating: Double = 0 {
        didSet {
            if rating != oldValue {
                refresh()
            }
        }
    }

    /// Sets whether or not the rating view can be changed by panning.
    @IBInspectable open var editable: Bool = true

    // MARK: Type

    @objc public enum FloatRatingViewType: Int {
        /// Integer rating
        case wholeRatings
        /// Double rating in increments of 0.5
        case halfRatings
        /// Double rating
        case floatRatings

        /// Returns true if rating can contain decimal places
        func supportsFractions() -> Bool {
            return self == .halfRatings || self == .floatRatings
        }
    }

    /// Float rating view type
    @IBInspectable open var type: FloatRatingViewType = .wholeRatings

    // MARK: Initializations

    required override public init(frame: CGRect) {
        super.init(frame: frame)

        initImageViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initImageViews()
    }

    // MARK: Helper methods

    private func initImageViews() {
        guard emptyStarViews.isEmpty && fullStarViews.isEmpty else {
            return
        }

        // Add new image views
        for _ in 0..<maxRating {
            let emptyStarImageView = UIImageView()
            emptyStarImageView.contentMode = imageContentMode
            emptyStarImageView.image = emptyStarImage
            emptyStarViews.append(emptyStarImageView)
            addSubview(emptyStarImageView)

            let fullStarImageView = UIImageView()
            fullStarImageView.contentMode = imageContentMode
            fullStarImageView.image = fullStarImage
            fullStarViews.append(fullStarImageView)
            addSubview(fullStarImageView)
        }
    }


    private func removeImageViews() {
        // Remove old image views
        for i in 0..<emptyStarViews.count {
            var imageView = emptyStarViews[i]
            imageView.removeFromSuperview()
            imageView = fullStarViews[i]
            imageView.removeFromSuperview()
        }
        emptyStarViews.removeAll(keepingCapacity: false)
        fullStarViews.removeAll(keepingCapacity: false)
    }

    // Refresh hides or shows full images
    private func refresh() {
        for i in 0..<fullStarViews.count {
            let imageView = fullStarViews[i]

            if rating >= Double(i+1) {
                imageView.layer.mask = nil
                imageView.isHidden = false
            } else if rating > Double(i) && rating < Double(i+1) {
                // Set mask layer for full image
                let maskLayer = CALayer()
                maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Double(i))*imageView.frame.size.width, height: imageView.frame.size.height)
                maskLayer.backgroundColor = UIColor.black.cgColor
                imageView.layer.mask = maskLayer
                imageView.isHidden = false
            } else {
                imageView.layer.mask = nil;
                imageView.isHidden = true
            }
        }
    }

    // Calculates the ideal ImageView size in a given CGSize
    private func sizeForImage(_ image: UIImage, inSize size: CGSize) -> CGSize {
        let imageRatio = image.size.width / image.size.height
        let viewRatio = size.width / size.height

        if imageRatio < viewRatio {
            let scale = size.height / image.size.height
            let width = scale * image.size.width

            return CGSize(width: width, height: size.height)
        } else {
            let scale = size.width / image.size.width
            let height = scale * image.size.height

            return CGSize(width: size.width, height: height)
        }
    }

    // Calculates new rating based on touch location in view
    private func updateLocation(_ touch: UITouch) {
        guard editable else {
            return
        }

        let touchLocation = touch.location(in: self)
        var newRating: Double = 0
        for i in stride(from: (maxRating-1), through: 0, by: -1) {
            let imageView = emptyStarViews[i]
            guard touchLocation.x > imageView.frame.origin.x else {
                continue
            }

            // Find touch point in image view
            let newLocation = imageView.convert(touchLocation, from: self)

            // Find decimal value for float or half rating
            if imageView.point(inside: newLocation, with: nil) && (type.supportsFractions()) {
                let decimalNum = Double(newLocation.x / imageView.frame.size.width)
                newRating = Double(i) + decimalNum
                if type == .halfRatings {
                    newRating = Double(i) + (decimalNum > 0.75 ? 1 : (decimalNum > 0.25 ? 0.5 : 0))
                }
            } else {
                // Whole rating
                newRating = Double(i) + 1.0
            }
            break
        }

        // Check min rating
        rating = newRating < Double(minRating) ? Double(minRating) : newRating

        // Update delegate
        delegate?.floatRatingView?(self, isUpdating: rating)
    }


    // MARK: UIView

    // Override to calculate ImageView frames
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard let emptyStarImage = emptyStarImage else {
            return
        }

        let desiredImageWidth = (frame.size.width - (6 * CGFloat(emptyStarViews.count))) / CGFloat(emptyStarViews.count)
        let maxImageWidth = max(minImageSize.width, desiredImageWidth)
        let maxImageHeight = max(minImageSize.height, frame.size.height)
        let imageViewSize = sizeForImage(emptyStarImage, inSize: CGSize(width: maxImageWidth, height: maxImageHeight))
        let imageXOffset = (frame.size.width - (imageViewSize.width * CGFloat(emptyStarViews.count))) /
            CGFloat((emptyStarViews.count))

        for i in 0..<maxRating {

            let yAxis = (maxImageHeight - imageViewSize.height ) / 2
            let imageFrame = CGRect(x: i == 0 ? 0 : CGFloat(i)*(imageXOffset+imageViewSize.width), y: yAxis, width: imageViewSize.width, height: imageViewSize.height)

            var imageView = emptyStarViews[i]
            imageView.frame = imageFrame

            imageView = fullStarViews[i]
            imageView.frame = imageFrame
        }

        refresh()
    }


    // MARK: Touch events

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Update delegate
        delegate?.floatRatingView?(self, didUpdate: rating)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Update delegate
        delegate?.floatRatingView?(self, didUpdate: rating)
    }
}
