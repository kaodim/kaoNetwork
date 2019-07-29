//
//  ReviewListViewModel.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

public typealias ReviewListResult = (meta: KaoPagination, list: [Review], rating: Rating)
public typealias ReviewListCellCallback = ((_ review: Review, _ indexPath: IndexPath) -> Void)?

open class ReviewListViewModel: TablePaginationViewModel {

    public var replyTapped: ReviewListCellCallback = nil
    public var editTapped: ReviewListCellCallback = nil
    public var configureHeaderLayout: ((_ rating: Rating) -> Void)?
    public var localization: RatingReviewLocalization = RatingReviewLocalization()

    private var reviewList: [Review] = [] {
        didSet {
            let isFirstTime = oldValue.isEmpty
            replaceList(reviewList, isFirstTime: isFirstTime)
        }
    }
    private var rating: Rating! {
        didSet {
            configureHeaderLayout?(rating)
        }
    }

    func load(page: Int, _ completion: (() -> Void)? = nil) {
        getReviewList(page: page) { (srSelectResult) in
            self.configureResult(srSelectResult)
            completion?()
        }
    }

    func configureResult(_ reviewListResult: ReviewListResult) {
        self.rating = reviewListResult.2
        configurePagination(reviewListResult.0, object: reviewListResult.1)
    }

    func replaceList(_ reviewList: [Review], isFirstTime: Bool) {
        self.items = []
        let item = ReviewListItems(reviewList, totalReview: self.meta?.totalCount ?? 0, localization: localization, replyTapped: replyTapped, editTapped: editTapped)
        self.items.append(item)

        if isFirstTime {
            // reload table twice for collection content view issue
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.dataConfigured?()
            }
        }

        self.dataConfigured?()
    }

    func updateReviews(_ review: Review, with reply: ReplyReview) {
        var updatedReview = review
        updatedReview.reply = reply

        var tempReviews = reviewList
        if let index = tempReviews.firstIndex(where: { $0.id == updatedReview.id }) {
            tempReviews[index] = updatedReview
        }
        reviewList = tempReviews
    }

    func sendReply(_ text: String, review: Review, successCompletion: (() -> Void)?) {
        guard let reviewId = review.id else { dropError("review id is nil?? Imposible... unless.."); return }
        sendReply(reviewId, text: text) { (reply) in
            self.updateReviews(review, with: reply)
            successCompletion?()
        }
    }

    func updateReply(_ text: String, review: Review, successCompletion: (() -> Void)?) {
        guard let replyId = review.reply?.id else { dropError("reply id is nil?? Imposible... unless.."); return }
        updateReply(replyId, text: text) { (reply) in
            self.updateReviews(review, with: reply)
            successCompletion?()
        }
    }
    // MARK: - Web Service
    open func getReviewList(page: Int, _ completion: @escaping (_ reviewListResult: ReviewListResult) -> Void) { }

    open func sendReply(_ reviewId: Int, text: String, completion: @escaping (_ reviewListResult: ReplyReview) -> Void) { }

    open func updateReply(_ replyId: Int, text: String, completion: @escaping (_ reviewListResult: ReplyReview) -> Void) { }

    // MARK: - PaginationProtocol method
    override open func nextPage(page: Int) {
        load(page: page)
    }

    override open func objectIsEmpty(_ object: Any) -> Bool {
        guard let reviews = object as? [Review] else { return true }
        return reviews.isEmpty
    }

    override open func appendObject(_ object: Any) {
        guard let reviews = object as? [Review] else { return }
        reviewList += reviews
    }

    override open func replaceObject(_ object: Any) {
        guard let reviews = object as? [Review] else { return }
        reviewList = reviews
    }
}
