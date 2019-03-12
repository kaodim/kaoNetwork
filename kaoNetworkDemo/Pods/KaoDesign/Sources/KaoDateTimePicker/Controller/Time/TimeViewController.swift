//
//  TimeViewController.swift
//  Kaodim
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, KaoDateTimePickerHelper {

    @IBOutlet weak var timeCollectionView: UICollectionView!

    @IBOutlet weak var confirmButton: KaoButton!

    @IBOutlet weak var chooseTime: KaoLabel!
    

    @IBOutlet weak var headerDate: UILabel! {
        didSet {
            guard let model = headerDateModel else {
                self.headerDate.text = ""
                return
            }
            self.headerDate.text = formattedDateFromString(dateString: model.date ?? "", withFormat: "E,d MMMM")
        }
    }

    var selectedTime: [IndexPath] = []

    var headerDateModel: DateTimeSurchargeDate?

    var timeModel: TimeModel?

    var tips: EasyTipView?

    override func viewDidLoad() {
        super.viewDidLoad()
        chooseTime.font =  UIFont.kaoFont(style: .bold, size: .title1)
        //confirmButton.isEnabled = false

    }

    //MARK:- Action
    @IBAction func change_date_Action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func confirmDateAction(_ sender: UIButton) {
        if self.selectedTime.count > 0 {
            guard let indexPath = self.selectedTime.first else { return }
            guard let model = self.timeModel else { return }
            guard let picker = model.surchargeTimes else { return }
            let time = picker[indexPath.row]

            if let handler = DateTimeManager.handler {
                _ = handler(nil, time)
            }

            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func close_Action(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }


    //MARK:- CollectionView Delegate & Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.timeModel else { return 0 }
        guard let picker = model.surchargeTimes else { return 0 }
        return picker.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: TimeCollectionViewCell.self), for: indexPath) as? TimeCollectionViewCell

        guard let model = self.timeModel else { return cell! }
        guard let picker = model.surchargeTimes else { return cell! }

        let time = picker[indexPath.row]

        let timeString = formattedDateFromString(dateString: time.time ?? "", withFormat: "HH:mm a") ?? ""
        let moneyString = time.amountText ?? "0"

        if time.available ?? true {
            cell?.isCellSelected(self.selectedTime.contains(indexPath), money: time.amountText ?? "")
        } else {
            cell?.isCellSelected(self.selectedTime.contains(indexPath), money: time.amountText ?? "")
        }

        cell?.wrap(date: timeString, money: moneyString, isSelected: self.selectedTime.contains(indexPath))

        if !(time.available ?? true) {
            cell?.disableCell = true
        }

        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let model = self.timeModel {
            if let picker = model.surchargeTimes {
                if let availability = picker[indexPath.row].available {
                    if !availability {
                        self.showTipView(indexPath: indexPath)
                        return
                    }
                }

            }
        }

        if self.selectedTime.contains(indexPath) {
            if let index = self.selectedTime.firstIndex(of: indexPath) {
                self.selectedTime.remove(at: index)
                confirmButton.isEnabled = false
            }
        } else {
            self.selectedTime = [indexPath]
            confirmButton.isEnabled = true
        }

        if self.selectedTime.count > 0 {
            self.confirmButton.backgroundColor = UIColor.purple
        } else {
            self.confirmButton.backgroundColor = UIColor.lightGray
        }
        tips?.dismiss()
        collectionView.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40.00) / 3.75
        return CGSize.init(width: width, height: width - 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.00
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.00
    }
}

//MARK: ScrollView delegates

extension TimeViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.tips?.dismiss()
    }
}


//MARK: Tip View
extension TimeViewController {
    func showTipView(indexPath: IndexPath) -> Void {
        if let cell = timeCollectionView.cellForItem(at: indexPath) {
            let preferences = EasyTipView.globalPreferences
            let text = "All the available time for this job for today has passed. Please try other dates."
            tips = EasyTipView.init(text: text, preferences: preferences)
            tips?.show(animated: true, forView: cell.contentView, withinSuperview:nil)
        }
    }
}
