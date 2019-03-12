//
//  KaoPaginationViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

open class KaoPaginationViewController: KaoBaseViewController, UIScrollViewDelegate {

    private var needsLoadDataSet: Bool = true
    private var meta: KaoPagination?
    public var displayEmptyDataSet: Bool = false
    public lazy var paginationLoader: UIActivityIndicatorView = {
        let view = kaoIndicatorView()
        return view
    }()

    open func replaceObject(_ object: Any) { }
    open func appendObject(_ object: Any) { }
    open func objectIsEmpty(_ object: Any) -> Bool { return true }
    open func nextPage(page: Int) { }

    public func configurePagination(_ meta: KaoPagination?, object: Any) {
        self.meta = meta
        self.needsLoadDataSet = (meta?.currentPage != meta?.totalPages)
        displayEmptyDataSet = objectIsEmpty(object)

        if displayEmptyDataSet || !needsLoadDataSet {
            self.paginationLoader.stopAnimating()
        } else {
            self.paginationLoader.startAnimating()
        }

        if meta?.currentPage == 1 {
            self.replaceObject(object)
        } else {
            if !displayEmptyDataSet {
                /// Append new dataset to list
                self.appendObject(object)
            } else {
                /// Insert as new list
                self.replaceObject(object)
            }
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.bounds.height
        let currentOffsetY = scrollView.contentOffset.y
        /// Pagination check
        if let nextPage = meta?.nextPage, needsLoadDataSet, (currentOffsetY) > (contentHeight - frameHeight) {
            needsLoadDataSet = false
            self.nextPage(page: nextPage)
        }
    }
}
