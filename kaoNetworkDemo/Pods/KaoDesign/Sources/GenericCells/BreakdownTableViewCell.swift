//
//  BreakdownTableViewCell.swift
//  KaoDesign
//
//  Created by Augustius on 27/05/2019.
//

import Foundation

public struct BreakdownTableViewCellData {
    public let rightFont: UIFont
    public let leftFont: UIFont
    public let rightText: NSAttributedString?
    public let leftText: NSAttributedString?
    public let rightColor: UIColor
    public let leftColor: UIColor
    
    public init(_ rightFont: UIFont = UIFont.kaoFont(style: .regular, size: 15),
         leftFont: UIFont = UIFont.kaoFont(style: .regular, size: 15),
         rightText: NSAttributedString? = nil, leftText: NSAttributedString? = nil,
         rightColor: UIColor = UIColor.kaoColor(.black),
         leftColor: UIColor = UIColor.kaoColor(.black)) {
        self.rightFont = rightFont
        self.leftFont = leftFont
        self.rightText = rightText
        self.leftText = leftText
        self.rightColor = rightColor
        self.leftColor = leftColor
    }
}

public class BreakdownTableViewCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet private weak var cardViewTrailing: NSLayoutConstraint!
    @IBOutlet private weak var cardViewLeading: NSLayoutConstraint!
    @IBOutlet private weak var cardViewTop: NSLayoutConstraint!
    @IBOutlet private weak var cardViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var seperatorBottom: NSLayoutConstraint!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var leftLabel: KaoLabel!
    @IBOutlet private weak var rightLabel: KaoLabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        let defaultUI = BreakdownTableViewCellData.init(rightText: "".attributeString(), leftText: "".attributeString())
        configureUI(defaultUI)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        hideSeperatorLine(lineBottomSpace: 0)
        configureEdge(UIEdgeInsets(top: 7, left: 16, bottom: 7, right: 16))
    }
    
    public func configureUI(_ uiData: BreakdownTableViewCellData) {
        leftLabel.attributedText = uiData.leftText
        rightLabel.attributedText = uiData.rightText
        leftLabel.textColor = uiData.leftColor
        rightLabel.textColor = uiData.rightColor
        leftLabel.font = uiData.leftFont
        rightLabel.font = uiData.rightFont
    }
    
    public func configureEdge(_ edge: UIEdgeInsets) {
        cardViewTop.constant = edge.top
        cardViewBottom.constant = edge.bottom
        cardViewLeading.constant = edge.left
        cardViewTrailing.constant = edge.right
    }

    public func hideSeperatorLine(_ hide: Bool = true, lineBottomSpace: CGFloat = 12) {
        seperatorView.isHidden = hide
        seperatorBottom.constant = lineBottomSpace
    }
}
