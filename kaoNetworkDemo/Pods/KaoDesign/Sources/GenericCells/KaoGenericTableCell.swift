//
//  KaoGenericTableCell.swift
//  KaoDesign
//
//  Created by Augustius on 27/05/2019.
//

import Foundation

public class KaoGenericTableCell<layout: UIView>: UITableViewCell {

    public let customView: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.customView = layout()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        selectionStyle = .none
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        customView.setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
