//
//  TablePaginationViewModel.swift
//  KaoDesign
//
//  Created by augustius cokroe on 14/03/2019.
//

import Foundation
import DZNEmptyDataSet

open class TablePaginationViewModel: TableViewModel, KaoPaginationProtocol, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    open lazy var loader: UIActivityIndicatorView = {
        let view = kaoIndicatorView()
        return view
    }()

    open var emptyStateView: UIView = UIView()
    open var emptyBackgroundColor: UIColor = .white

    // MARK: - KaoPaginationProtocol
    open var scrollDownType: Bool = true
    open var needsLoadDataSet: Bool = true
    open var meta: KaoPagination?
    open var displayEmptyDataSet: Bool = false
    open var paginationLoader: UIActivityIndicatorView { return loader }

    open func nextPage(page: Int) { }
    open func objectIsEmpty(_ object: Any) -> Bool { return true }
    open func appendObject(_ object: Any) { }
    open func replaceObject(_ object: Any) { }
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrolling(scrollView)
    }

    // MARK: - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
    public func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return emptyStateView
    }

    open func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyBackgroundColor
    }

    open func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }

    open func emptyDataSetShouldFade(in scrollView: UIScrollView!) -> Bool {
        return true
    }

    open func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return displayEmptyDataSet
    }
}
