//
//  ReviewListCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 15/04/2019.
//

import Foundation

public class ReviewListCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var userIcon: UIImageView!
    @IBOutlet private weak var userName: KaoLabel!
    @IBOutlet private weak var serviceName: KaoLabel!
    @IBOutlet private weak var ratingView: KaoRatingView!
    @IBOutlet private weak var dateRange: KaoLabel!
    @IBOutlet private weak var reviewLabel: KaoLabel!

    @IBOutlet private weak var selectedTagsContainer: UIView!
    @IBOutlet private weak var complimentedLabel: KaoLabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!

    @IBOutlet private weak var replyButton: UIButton!

    @IBOutlet private weak var replyViewContainer: UIView!
    @IBOutlet private weak var replySeperatorView: UIView!
    @IBOutlet private weak var replyLabel: KaoLabel!
    @IBOutlet private weak var replyDescLabel: KaoLabel!

    @IBOutlet private weak var editButton: UIButton!

    private lazy var leftVerticalFlowLayout: UICollectionViewLayout = {
        let layout = LeftVerticalFlowLayout()
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
            // Fallback on earlier versions
            layout.estimatedItemSize = CGSize(width: 271, height: 37)
        }
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 12.0
        layout.scrollDirection = .vertical
        return layout
    }()

    private let cellIdentifier = "ReviewListTagCell"
    private var currentReview: Review?
    private var selectedTags: [SelectedReviewTag] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var replyTapped: ((_ review: Review) -> Void)?
    var editTapped: ((_ review: Review) -> Void)?

    override public func awakeFromNib() {
        super.awakeFromNib()

        userIcon.makeRoundCorner()
        userName.font = UIFont.kaoFont(style: .medium, size: 15)
        serviceName.font = UIFont.kaoFont(style: .regular, size: 14)
        dateRange.font = UIFont.kaoFont(style: .regular, size: 13)
        reviewLabel.font = UIFont.kaoFont(style: .regular, size: 15)
        replyButton.titleLabel?.font = UIFont.kaoFont(style: .regular, size: 15)
        replySeperatorView.addCornerRadius(2)
        replyLabel.font = UIFont.kaoFont(style: .medium, size: 14)
        replyDescLabel.font = UIFont.kaoFont(style: .regular, size: 15)
        editButton.titleLabel?.font = UIFont.kaoFont(style: .regular, size: 15)
        complimentedLabel.font = UIFont.kaoFont(style: .regular, size: 13)

        collectionView.dataSource = self
        collectionView.collectionViewLayout = leftVerticalFlowLayout
        collectionView.register(UIView.nibFromDesignIos(cellIdentifier) , forCellWithReuseIdentifier: cellIdentifier)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        selectedTags = []
        collectionView.reloadData()
    }

    public func configure(_ review: Review, localization: RatingReviewLocalization) {
        currentReview = review
        selectedTags = currentReview?.reviewTags ?? []
        userIcon?.cache(withURL: review.avatarUrl, placeholder: UIImage.imageFromDesignIos("avatar"))
        userName.text = review.name
        serviceName.text = review.description
        ratingView.rating = Float(review.rating ?? 0)
        dateRange.text = review.createdAtStr
        reviewLabel.text = review.comment

        configureSelectedTags(review, localization: localization)
        configureReply(review, localization: localization)
        self.contentView.setNeedsLayout()
    }

    private func configureSelectedTags(_ review: Review, localization: RatingReviewLocalization) {
        if !review.reviewTags.isEmpty && review.rating == 5 {
            complimentedLabel.text = localization.translate(.complimented)+":"
            selectedTagsContainer.isHidden = false
        } else {
            selectedTagsContainer.isHidden = true
        }
    }

    private func configureReply(_ review: Review, localization: RatingReviewLocalization) {
        replyButton.setTitle(localization.translate(.reply), for: .normal)
        replyButton.isHidden = !(review.canReply ?? false)

        if let reply = review.reply {
            replyButton.isHidden = true
            replyViewContainer.isHidden = false
            let text1 = review.businessName
            let text2 = localization.translate(.replied)
            let joinedText = [text1, text2].joined(separator: " ")
            let attrStr = NSMutableAttributedString(string: joinedText)
            let attrDict = [NSAttributedStringKey.font: UIFont.kaoFont(style: .regular, size: 14)]
            attrStr.addAttributes(attrDict, range: NSRange(location: joinedText.count - text2.count, length: text2.count))
            replyLabel.attributedText = attrStr
            replyDescLabel.text = reply.comment
            editButton.setTitle(localization.translate(.edit), for: .normal)
            editButton.isHidden = !(reply.canEdit ?? false)
        } else {
            replyViewContainer.isHidden = true
        }
    }

    @IBAction private func replyTap() {
        guard let currentReview = currentReview else { return }
        replyTapped?(currentReview)
    }

    @IBAction private func editTap() {
        guard let currentReview = currentReview else { return }
        editTapped?(currentReview)
    }

    override public func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

        collectionView.layoutIfNeeded()
        collectionViewHeight.constant = collectionView.contentSize.height
        return self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }

}

extension ReviewListCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ReviewListTagCell else {
            fatalError("Cell not found.")
        }
        let reviewTag = selectedTags[indexPath.row]
        cell.configure(reviewTag.iconUrl, text: reviewTag.name)
        return cell
    }
}

