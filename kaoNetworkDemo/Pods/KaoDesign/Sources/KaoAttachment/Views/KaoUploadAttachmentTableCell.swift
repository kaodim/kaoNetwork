//
//  KaoUploadAttachmentTableCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/02/2019.
//

import Foundation

public class KaoUploadAttachmentTableCell: UITableViewCell {

    @IBOutlet public weak var attachmentView: KaoUploadAttachmentView!
    @IBOutlet private weak var uploadHeight: NSLayoutConstraint!
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var leadingSpace: NSLayoutConstraint!
    @IBOutlet weak var trailingSpace: NSLayoutConstraint!

    override public func awakeFromNib() {
        super.awakeFromNib()
        uploadHeight.constant = attachmentView.idealHeight
    }

    public func updateViewHeight() {
        uploadHeight.constant = attachmentView.idealHeight
    }

    public func configureEdge(_ edge: UIEdgeInsets) {
        topSpace.constant = edge.top
        bottomSpace.constant = edge.bottom
        leadingSpace.constant = edge.left
        trailingSpace.constant = edge.right
    }
}
