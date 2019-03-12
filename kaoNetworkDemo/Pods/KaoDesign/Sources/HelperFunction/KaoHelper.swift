//
//  KaoHelper.swift
//  KaoDesign
//
//  Created by augustius cokroe on 11/03/2019.
//

import Foundation

public func kaoIndicatorView() -> UIActivityIndicatorView {
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    indicatorView.hidesWhenStopped = true
    indicatorView.frame.size = CGSize(width: 30, height: 30)
    return indicatorView
}
