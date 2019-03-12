//
//  KaoUploadOptionCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/02/2019.
//

import Foundation

public class KaoUploadOptionCell: UICollectionViewCell {

    @IBOutlet private weak var borderIcon: UIImageView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var optionLabel: KaoLabel!

    override public func awakeFromNib() {
        super.awakeFromNib()
        borderIcon.image = UIImage.imageFromDesignIos("attachment-type_border")
        optionLabel.font = UIFont.kaoFont(style: .regular, size: .small)
    }

    public func configure(_ type: KaoAttachmentType, text: String?) {
        icon.image = type.imageName()
        optionLabel.text = text
    }
}
