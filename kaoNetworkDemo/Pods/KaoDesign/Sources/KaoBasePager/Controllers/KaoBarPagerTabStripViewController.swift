//
//  KaoBarPagerTabStripViewController.swift
//  Kaodim
//
//  Created by augustius cokroe on 29/10/2018.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import Foundation
import XLPagerTabStrip

open class KaoBarPagerTabStripViewController: BaseButtonBarPagerTabStripViewController<KaoPageBarCell> {
    
    public var desiredIndex: Int?

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        let podBundle = Bundle(for: KaoPageBarCell.self)
        let bundleURL = podBundle.url(forResource: "KaoCustomPod", withExtension: "bundle")!
        let bundle = Bundle(url: bundleURL)
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "KaoPageBarCell", bundle: bundle, width: { _ in
            return 55.0
        })
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func viewDidLoad() {
        navigationController?.navigationBar.kaodimStyle()
        configureTabbarSetting()
        super.viewDidLoad()
        configureTabbar()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.showBottomLine(false)
        self.moveToDesiredIndex()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.showBottomLine()
    }

    private func configureTabbarSetting() {
        /// Configure tab bar view
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor.kaoColor(.crimson)
        settings.style.buttonBarItemTitleColor = UIColor.kaoColor(.crimson)
        settings.style.buttonBarItemFont = UIFont.kaoFont(style: .regular, size: .regular)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarHeight = 35.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { (oldCell: KaoPageBarCell?, newCell: KaoPageBarCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.kaoColor(.greyishBrown)
            newCell?.label.textColor = UIColor.kaoColor(.crimson)
        }
    }

    private func configureTabbar() {
        buttonBarView.layer.masksToBounds = false
        buttonBarView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        buttonBarView.layer.shadowColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5).cgColor
        buttonBarView.layer.shadowOpacity = 1
        buttonBarView.layer.shadowRadius = 1
    }
    
    private func moveToDesiredIndex() {
        if let index = desiredIndex {
            desiredIndex = nil
            DispatchQueue.main.async {
                self.moveToViewController(at: index, animated: false)
                self.buttonBarView.reloadData()
            }
        }
    }

    // MARK: - PagerTabStripDataSource
    override open func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return super.viewControllers(for: self)
    }

    override open func configure(cell: KaoPageBarCell, for indicatorInfo: IndicatorInfo) {
        cell.label.text = indicatorInfo.title
        cell.unreadButton.makeRoundCorner()
        cell.unreadButton.setBackgroundColor(color: (indicatorInfo.image == nil) ? UIColor.white  : UIColor.kaoColor(.crimson), forState: .normal)
        cell.label.font = UIFont.kaoFont(style: .regular, size: 15)
    }

    override open func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
    }
}
