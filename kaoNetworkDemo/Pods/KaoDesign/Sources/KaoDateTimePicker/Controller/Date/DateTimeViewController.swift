//
//  DateTimeViewController.swift
//  KaodimIosDesign
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

class DateTimeViewController: UIViewController {

    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    @IBOutlet weak var confirmButton: KaoButton!
    @IBOutlet weak var chooseDate: KaoLabel!
    var dateModel : DateTimeModel?
    var tips: EasyTipView?
    var selectedDate : [IndexPath] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmButton.isEnabled = false
        chooseDate.font =  UIFont.kaoFont(style: .bold, size: .title1)

        let nib = UIView.nibFromDesignIos("CollectionHeaderReusableView")
        self.dateCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        let layout = self.dateCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        self.dateCollectionView.delegate = self
        self.dateCollectionView.reloadData()
    }

    //MARK: IBActions
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selectDateActionDismiss(_ sender: UIButton) {
        self.callbackIntantiation()
    }

    func callbackIntantiation() {
        guard let indexPath = self.selectedDate.first else { return }
        guard let model  = self.dateModel else { return  }
        guard let picker = model.datePickers else { return  }
        guard let date  = picker[indexPath.section].surchargeDates?[indexPath.row] else { return  }
        if let handler = DateTimeManager.handler {
            let timeJson = handler(date, nil)
            self.timeScreen(withJson: timeJson, date: date)
        }
    }

    func timeScreen(withJson json: String, date: DateTimeSurchargeDate) {
        guard let timeData = json.data(using: .utf8) else { return }

        do {
            let timeModel = try JSONDecoder().decode(TimeModel.self, from: timeData)
            let story = UIStoryboard.StoryboardFromDesignIos("DateTime")
            guard let vc = story.instantiateViewController(withIdentifier: String(describing: TimeViewController.self)) as? TimeViewController else { return }
            vc.timeModel = timeModel
            vc.headerDateModel = date
            self.navigationController?.pushViewController(vc, animated: true)
        } catch {
            print(error)
        }

    }
}


//MARK: ScrollView delegates

extension DateTimeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tips?.dismiss()
    }
}
