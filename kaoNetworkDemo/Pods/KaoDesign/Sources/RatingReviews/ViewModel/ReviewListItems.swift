//
//  ReviewListItems.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

public class ReviewListItems: TableViewVMProtocol {

    public var rowCount: Int {
        return reviews.count
    }

    private var reviews: [Review]
    private var totalReview: Int
    private var localization: RatingReviewLocalization

    var replyTapped: ReviewListCellCallback
    var editTapped: ReviewListCellCallback

    public init(_ reviews: [Review], totalReview: Int, localization: RatingReviewLocalization, replyTapped: ReviewListCellCallback, editTapped: ReviewListCellCallback) {
        self.reviews = reviews
        self.totalReview = totalReview
        self.localization = localization
        self.replyTapped = replyTapped
        self.editTapped = editTapped
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = self.reviews[indexPath.row]
        let cell: ReviewListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(review, localization: localization)
        cell.replyTapped = { (replyText) in
            self.replyTapped?(replyText, indexPath)
        }
        cell.editTapped = { (replyText) in
            self.editTapped?(replyText, indexPath)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ReviewListHeaderView()
        let title = localization.translate(.reviews).capitalized
        let desc = "• \(totalReview.description) \(localization.translate(.reviews))"
        view.configure(title, desc: desc)
        return view
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
