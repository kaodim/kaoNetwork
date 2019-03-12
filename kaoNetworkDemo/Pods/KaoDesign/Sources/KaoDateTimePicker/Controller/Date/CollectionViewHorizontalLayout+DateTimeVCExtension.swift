//
//  CollectionViewHorizontalLayout+DateTimeVCExtension.swift
//  KaodimIosDesign
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit


extension DateTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, KaoDateTimePickerHelper {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let model = self.dateModel else { return 0 }
        guard let picker = model.datePickers else { return 0 }
        return picker.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.dateModel else { return 0 }
        guard let picker = model.datePickers else { return 0 }
        guard let items = picker[section].surchargeDates else { return 0 }
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: DatesCollectionViewCell.self), for: indexPath) as? DatesCollectionViewCell
        guard let model = self.dateModel else { return cell! }
        guard let picker = model.datePickers else { return cell! }
        guard let items = picker[indexPath.section].surchargeDates else { return cell! }

        if let available = items[indexPath.row].available, available {
            cell?.wrapCell(date: items[indexPath.row].date ?? "", money: items[indexPath.row].amountText ?? "")
        } else {
            cell?.wrapCell(date: items[indexPath.row].date ?? "", money: "")
        }
        cell?.isCellSelected(self.selectedDate.contains(indexPath))

        if !(items[indexPath.row].available ?? true) {
            cell?.disableCell = true
        }
        return cell!
    }

    //Header initialisation for collectionview section header

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader", for: indexPath) as! CollectionHeaderReusableView
        guard let model = self.dateModel else { return header }
        guard let picker = model.datePickers else { return header }
        guard let items = picker[indexPath.section].month else { return header }
        let monthName = formattedDateFromString(dateString: items, withFormat: "MMMM")
        header.monthLabel.text = monthName
        return header
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 65.00, height: 35.00)
    }

    //cell size initialisation
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40.00)
        return CGSize.init(width: width / 3.75, height: ((width / 3.75) - 5))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let model = self.dateModel {
            if let picker = model.datePickers {
                if let items = picker[indexPath.section].surchargeDates {
                    if let availibility = items[indexPath.row].available {
                        if !availibility {
                            tips?.dismiss()
                            showTipView(indexPath: indexPath)
                            return
                        }
                    }
                }
            }
        }


        if self.selectedDate.contains(indexPath) {
            if let index = self.selectedDate.firstIndex(of: indexPath) {
                self.selectedDate.remove(at: index)
            }
            self.confirmButton.isEnabled = false
        } else {
            self.confirmButton.isEnabled = true
            self.selectedDate = [indexPath]
            tips?.dismiss()
        }

        collectionView.reloadData()
    }
}

//MARK: Tip View
extension DateTimeViewController {
    func showTipView(indexPath: IndexPath) -> Void {
        if let cell = dateCollectionView.cellForItem(at: indexPath) {
            let preferences = EasyTipView.globalPreferences
            let text = "All the available time for this job for today has passed. Please try other dates."
            tips = EasyTipView.init(text: text, preferences: preferences)
            tips?.show(animated: true, forView: cell.contentView, withinSuperview:nil)
        }
    }
}
