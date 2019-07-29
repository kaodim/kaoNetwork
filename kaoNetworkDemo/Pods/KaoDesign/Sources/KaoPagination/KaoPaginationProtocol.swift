//
//  KaoPaginationProtocol.swift
//  DZNEmptyDataSet
//
//  Created by augustius cokroe on 11/03/2019.
//

import Foundation

public protocol KaoPaginationProtocol: class {
    var scrollDownType: Bool { get set } // decide scroll up or down for pagination
    var needsLoadDataSet: Bool { get set }
    var meta: KaoPagination? { get set }
    var displayEmptyDataSet: Bool { get set }
    var paginationLoader: UIActivityIndicatorView { get }

    func replaceObject(_ object: Any)
    func appendObject(_ object: Any)
    func objectIsEmpty(_ object: Any) -> Bool
    func nextPage(page: Int)
}

extension KaoPaginationProtocol {

    public func configurePagination(_ meta: KaoPagination?, object: Any) {
        self.meta = meta
        self.needsLoadDataSet = (meta?.currentPage != meta?.totalPages)
        displayEmptyDataSet = objectIsEmpty(object)

        if meta?.currentPage == 1 {
            self.replaceObject(object)
        } else {
//            if !displayEmptyDataSet {
                /// Append new dataset to list
                self.appendObject(object)
//            } else {
//                /// Insert as new list
//                self.replaceObject(object)
//            }
        }
        self.paginationLoader.stopAnimating()
    }

    // call this function from viewdidScroll
    public func handleScrolling(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.bounds.height
        let currentOffsetY = scrollView.contentOffset.y
        /// Pagination check
        if let nextPage = meta?.nextPage, needsLoadDataSet {
            if scrollDownType {
                if (currentOffsetY) > (contentHeight - frameHeight) {
                    loadNextPage(nextPage: nextPage)
                }
            } else {
                if currentOffsetY < 0 {
                    loadNextPage(nextPage: nextPage)
                }
            }
        }
    }

    private func loadNextPage(nextPage: Int) {
        needsLoadDataSet = false
        self.paginationLoader.startAnimating()
        self.nextPage(page: nextPage)
    }
}
