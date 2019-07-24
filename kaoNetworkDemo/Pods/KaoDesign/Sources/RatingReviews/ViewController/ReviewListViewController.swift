//
//  ReviewListViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

open class ReviewListViewController: KaoBaseViewController {

    private lazy var headerView: RatingAvgHeaderView = {
        let view = RatingAvgHeaderView()
        return view
    }()

    public lazy var tableView: UITableView = {
        let view = UITableView.kaoDefault(style: .grouped, delegate: reviewListViewModel, dataSource: reviewListViewModel, bottomLoading: reviewListViewModel.paginationLoader)
        view.registerFromDesignIos(ReviewListCell.self)
        view.setAndLayoutTableHeaderView(header: headerView)
        view.separatorStyle = .none
        return view
    }()

    public var reviewListViewModel: ReviewListViewModel!
    public var localization: RatingReviewLocalization = RatingReviewLocalization()
    private var lastScrollIndex: IndexPath?

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureLayout()
    }

    open func configureViewModel() {
        // override then initialize bfr call super.configureViewModel
        reviewListViewModel.localization = localization
        reviewListViewModel.replyTapped = replyTapped
        reviewListViewModel.editTapped = editTapped
        reviewListViewModel.configureHeaderLayout = configureHeaderLayout
        reviewListViewModel.dataConfigured = reloadTable
        reviewListViewModel.load(page: 1)
    }

    private func configureLayout() {
        view.addSubview(tableView)
        view.sendSubview(toBack: tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeTopAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }

    private func scrollTo(_ indexPath: IndexPath) {
        lastScrollIndex = indexPath
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 500, 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    private func editViewDidDismiss() {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }

    private func scrollToLastIndexIfExist() {
        if let lastIndex = lastScrollIndex {
            tableView.scrollToRow(at: lastIndex, at: .middle, animated: true)
        }
        lastScrollIndex = nil
    }

    // MARK: - Callback
    private func configureHeaderLayout(_ rating: Rating) {
        headerView.configure(rating, ratingText: localization.translate(.ratings))
    }

    open func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData() {
                self.scrollToLastIndexIfExist()
            }
        }
    }

    open func replyTapped(_ review: Review, _ indexPath: IndexPath) {
        scrollTo(indexPath)
        presentReviewListReplyVC(review, localization: localization, sendTapped: { (replyText) in
            self.reviewListViewModel.sendReply(replyText, review: review, successCompletion: {
                self.dismiss(animated: false, completion: nil)
            })
        }, viewDidDismiss: editViewDidDismiss)
    }

    open func editTapped(_ review: Review, _ indexPath: IndexPath) {
        scrollTo(indexPath)
        presentReviewListEditVC(review, localization: localization, sendTapped: { (replyText) in
            self.reviewListViewModel.updateReply(replyText, review: review, successCompletion: {
                self.dismiss(animated: false, completion: nil)
            })
        }, viewDidDismiss: editViewDidDismiss)
    }
}
