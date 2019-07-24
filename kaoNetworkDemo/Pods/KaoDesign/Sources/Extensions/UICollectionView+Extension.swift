//
//  UICollectionView+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

public extension UICollectionView {
    func reloadData(completion: @escaping() -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
