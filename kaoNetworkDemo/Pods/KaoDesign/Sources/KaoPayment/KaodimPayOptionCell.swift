//
//  KaodimPayOptionCell.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//

import Foundation

let kaodimPayIcon20 = UIImage.imageFromDesignIos("logo_kaodimpay")?.resizeImage(targetHeight: 20)

public class KaodimPayOptionCell: UITableViewCell, NibLoadableView, PayOptionProtocolCell {

    @IBOutlet private weak var iconButton: UIButton!
    @IBOutlet private weak var checkIconView: UIView!
    @IBOutlet private weak var checkIcon: UIImageView!
    @IBOutlet private weak var seperatorLine: UIView!

    override public func awakeFromNib() {
        super.awakeFromNib()
        configureSelected(false)
        iconButton.contentMode = .scaleAspectFit
        iconButton.setImage(kaodimPayIcon20, for: .normal)
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
        let cell: KaodimPayOptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
