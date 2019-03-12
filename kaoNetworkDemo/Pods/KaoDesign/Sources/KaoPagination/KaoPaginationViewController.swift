//
//  KaoPaginationViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 06/03/2019.
//

import Foundation

open class KaoPaginationViewController: KaoBaseViewController, UIScrollViewDelegate, KaoPaginationProtocol {

    public lazy var defaultPaginationLoader: UIActivityIndicatorView = {
        let view = kaoIndicatorView()
        return view
    }()

    public var scrollDownType: Bool = true
    public var needsLoadDataSet: Bool = true
    public var meta: KaoPagination?
    public var displayEmptyDataSet: Bool = false

    public var paginationLoader: UIActivityIndicatorView {
        return defaultPaginationLoader
    }

    open func nextPage(page: Int) { }
    open func objectIsEmpty(_ object: Any) -> Bool { return true }
    open func appendObject(_ object: Any) { }
    open func replaceObject(_ object: Any) { }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrolling(scrollView)
    }
}
