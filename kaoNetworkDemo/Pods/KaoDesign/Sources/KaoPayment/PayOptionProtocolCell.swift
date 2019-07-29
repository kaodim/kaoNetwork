//
//  PayOptionProtocolCell.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//

import Foundation

public protocol PayOptionProtocolCell: UITableViewCell {
    func configure(_ title: String, message: String)
    func configureSelected(_ selected: Bool)
    func hideCheckIcon(_ hide: Bool)
    func hideSeperator(_ hide: Bool)
    static func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PayOptionProtocolCell
}

public extension PayOptionProtocolCell {

    var unselectImage: UIImage? {
        return UIImage.imageFromDesignIos("form_selection_off")
    }

    var selectImage: UIImage? {
        return UIImage.imageFromDesignIos("form_selection_on")
    }

    func configure(_ title: String, message: String) { }
}
