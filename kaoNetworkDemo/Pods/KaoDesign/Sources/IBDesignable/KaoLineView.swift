//
//  KaoLineView.swift
//  KaodimIosDesign
//
//  Created by augustius cokroe on 24/07/2018.
//  Copyright © 2018 kaodim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class KaoLineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshView()
    }

    override public func prepareForInterfaceBuilder() {
        refreshView()
    }

    public func refreshView() {
        // Common logic goes here
        setAttributes()
        setConstraint()
    }

    private func setAttributes() {
        backgroundColor = .kaoColor(.whiteLilac)
    }

    private func setConstraint() {
        let heightConstraint = heightAnchor.constraint(equalToConstant: 1)
        addConstraint(heightConstraint)
    }
}
