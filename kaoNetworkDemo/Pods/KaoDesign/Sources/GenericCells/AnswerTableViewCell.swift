//
//  AnswerTableViewCell.swift
//  KaoDesign
//
//  Created by Ramkrishna on 27/05/2019.
//

import UIKit

public class AnswerTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var titleLabel: KaoLabel!
    @IBOutlet private weak var subTitleLabel: KaoLabel!
    @IBOutlet private weak var bulletView: UIView!
    @IBOutlet private weak var bulletLabel: KaoLabel!

    @IBOutlet private weak var editButton: UIButton!
    
    public var editButtonTapped: (() -> Void)?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }

    private func configureViews() {
        titleLabel.font = .kaoFont(style: .regular, size: 15.0)
        titleLabel.textColor = .kaoColor(.greyishBrown)

        subTitleLabel.font = .kaoFont(style: .regular, size: 16.0)
        subTitleLabel.textColor = .kaoColor(.black)

        bulletView.backgroundColor = UIColor.kaoColor(.grayChateau)
        bulletView.makeRoundCorner()

        bulletLabel.font = .kaoFont(style: .semibold, size: 10.0)
        bulletLabel.textColor = .white

        editButton.isHidden = true
    }
    
    public func configure(_ title: String, subTitle: String? = nil, number: String? = nil, editable: Bool? = false) {
        self.configure(title.attributeString(), subTitle: subTitle?.attributeString(), number: number, editable: editable)
    }

    public func configure(_ title: NSAttributedString, subTitle: NSAttributedString? = nil, number: String? = nil, editable: Bool? = false) {
        self.titleLabel.attributedText = title

        if subTitle != nil {
            self.subTitleLabel.attributedText = subTitle
        }

        configureBullet(number)
        configureButton(isEditing: editable)
        setNeedsLayout()
    }

    private func configureBullet(_ number: String?) {
        number == nil ? (bulletView.isHidden = true) : (bulletView.isHidden = false)
        bulletLabel.text = number
    }

    private func configureButton(isEditing: Bool?) {
        (isEditing ?? false) ? (editButton.isHidden = false) : (editButton.isHidden = true)
    }
    
    @IBAction func editButonTapped(_ sender: Any) {
        self.editButtonTapped?()
    }
}
