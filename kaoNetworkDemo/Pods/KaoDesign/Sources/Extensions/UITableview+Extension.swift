//
//  UITableview+Extension.swift
//  KaoDesign
//
//  Created by augustius cokroe on 25/10/2018.
//

import Foundation
import DZNEmptyDataSet
import UIKit

public extension UITableView {
    func removeFooterView() {
        tableFooterView = UIView(frame: CGRect.zero)
        tableFooterView?.isHidden = true
    }

    func removeLastSeparator() {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.frame.size.width, height: 1.0))
        tableFooterView = UIView(frame: frame)
    }

    func setAndLayoutTableHeaderView(header: UIView?) {
        self.tableHeaderView = header
        self.refreshLayoutTableHeaderView()
    }

    func refreshLayoutTableHeaderView() {
        guard let header = self.tableHeaderView else { return }
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableHeaderView = header
    }

    func setAndLayoutTableFooterView(footer: UIView?) {
        self.tableFooterView = footer
        refreshLayoutTableFooterView()
    }

    func refreshLayoutTableFooterView() {
        guard let footer = self.tableFooterView else { return }
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        let height = footer.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = footer.frame
        frame.size.height = height
        footer.frame = frame
        self.tableFooterView = footer
    }

    func reloadData(completion: @escaping() -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }

    func scrollToTop(_ animate: Bool = true) {
        setContentOffset(.zero, animated: animate)
    }

    func scrollToBottom(_ animate: Bool = true)  {
        let point = CGPoint(x: 0, y: self.contentSize.height + self.contentInset.bottom - self.frame.height)
        if point.y >= 0{
            self.setContentOffset(point, animated: animate)
        }
    }
}

public extension UITableView {
    class func kaoDefault(style: UITableView.Style = .plain, delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil, emptyDelegate: DZNEmptyDataSetDelegate? = nil, emptyDataSource: DZNEmptyDataSetSource? = nil, refresher: UIRefreshControl? = nil, bottomLoading: UIActivityIndicatorView? = nil) -> UITableView {
        let view = UITableView(frame: .zero, style: style)
        view.dataSource = dataSource
        view.delegate = delegate
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 50
        view.backgroundColor = .clear

        if let refresher = refresher {
            if #available(iOS 10.0, *) {
                view.refreshControl = refresher
            } else {
                view.backgroundView = refresher
            }
        }

        if let bottomLoading = bottomLoading {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100.0))
            bottomLoading.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: bottomLoading.bounds.height)
            view.tableFooterView = footerView
            view.tableFooterView?.addSubview(bottomLoading)
        }

        if let emptyDataSource = emptyDataSource {
            view.emptyDataSetSource = emptyDataSource
        }
        if let emptyDelegate = emptyDelegate {
            view.emptyDataSetDelegate = emptyDelegate
        }

        return view
    }
}
