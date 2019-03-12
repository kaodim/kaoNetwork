//
//  UIViewController+Presenter.swift
//  KaoDesign
//
//  Created by augustius cokroe on 01/03/2019.
//

import Foundation

public extension UIViewController {

    func presentImagePicker(imageURL: String? = nil, image: UIImage? = nil, data: Data? = nil) {
        let view = KaoImagePreviewViewController(imageURL: imageURL, image: image, data: data)
        present(view, animated: true, completion: nil)
    }
}
