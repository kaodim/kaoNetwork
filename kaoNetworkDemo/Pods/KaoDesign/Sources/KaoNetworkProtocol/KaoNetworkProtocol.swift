//
//  KaoNetworkProtocol.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

public protocol KaoNetworkProtocol {
    func retry()
    func addNetworkErrorView(_ errorView: UIView)
}
