//
//  UISearchBar+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 22/11/2018.
//

import Foundation

public extension UISearchBar {
    class func kaoDefault() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setImage(UIImage.icon(.search, color: .kaoColor(.crimson), size: CGSize(width: 18, height: 18)), for: .search, state: .normal)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .darkGray
            textfield.textAlignment = .left
            textfield.rightViewMode = .always
            textfield.clearButtonMode = .never
            textfield.font = .kaoFont(style: .regular, size: .regular)
            textfield.addBorderLine(width: 1.0, color: UIColor(red: 0.9, green: 0.91, blue: 0.91, alpha: 1))
            textfield.addCornerRadius(4.0)
        }
        if let cancelBarButton = searchBar.value(forKey: "cancelBarButtonItem") as? UIBarButtonItem {
            cancelBarButton.tintColor = .lightGray
        }
        return searchBar
    }
}
