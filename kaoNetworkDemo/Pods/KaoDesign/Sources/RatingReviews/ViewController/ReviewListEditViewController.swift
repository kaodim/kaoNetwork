//
//  ReviewListEditViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 16/04/2019.
//

import Foundation

class ReviewListEditViewController: ReviewListReplyViewController {

    override func configureEditContainer() {
        editContainer.configureForEdit(review, localization: localization)
    }
}

extension UIViewController {

    func presentReviewListEditVC(_ review: Review, localization: RatingReviewLocalization, sendTapped: ((_ text: String) -> Void)?, viewDidDismiss: (() -> Void)?) {
        let view = ReviewListEditViewController(review, localization: localization)
        view.sendTapped = sendTapped
        view.editViewDidDismiss = viewDidDismiss
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: false, completion: nil)
    }
}
