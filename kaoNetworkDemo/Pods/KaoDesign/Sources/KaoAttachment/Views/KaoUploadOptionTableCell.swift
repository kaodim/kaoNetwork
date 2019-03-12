//
//  KaoUploadOptionTableCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/02/2019.
//

import Foundation

public class KaoUploadOptionTableCell: UITableViewCell {

    @IBOutlet public weak var attachmentOptionView: KaoUploadOptionView!
    @IBOutlet private weak var optionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var leadingSpace: NSLayoutConstraint!
    @IBOutlet weak var trailingSpace: NSLayoutConstraint!

    override public func awakeFromNib() {
        super.awakeFromNib()
        attachmentOptionView.finalSizeConfigured = {
            self.optionViewHeight.constant = self.attachmentOptionView.idealHeight
            (self.superview as? UITableView)?.beginUpdates()
            (self.superview as? UITableView)?.endUpdates()
        }
    }

    public func configureEdge(_ edge: UIEdgeInsets) {
        topSpace.constant = edge.top
        bottomSpace.constant = edge.bottom
        leadingSpace.constant = edge.left
        trailingSpace.constant = edge.right
    }
}
