//
//  PayOptionCell.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//

import Foundation

public class PayOptionCell: UITableViewCell, NibLoadableView, PayOptionProtocolCell {

    @IBOutlet private weak var checkIconView: UIView!
    @IBOutlet private weak var checkIcon: UIImageView!
    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var messageLabel: KaoLabel!
    @IBOutlet private weak var seperatorLine: UIView!

    override public func awakeFromNib() {
        super.awakeFromNib()
        configureSelected(false)
        titleLabel.font = UIFont.kaoFont(style: .medium, size: 16)
        messageLabel.font = UIFont.kaoFont(style: .regular, size: 15)
    }

    public func configure(_ title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }

    public func configureSelected(_ selected: Bool) {
        checkIcon.image = selected ? selectImage : unselectImage
    }

    public func hideCheckIcon(_ hide: Bool) {
        checkIconView.isHidden = hide
    }

    public func hideSeperator(_ hide: Bool) {
        seperatorLine.isHidden = hide
    }

    public static func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PayOptionProtocolCell {
        let cell: PayOptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
