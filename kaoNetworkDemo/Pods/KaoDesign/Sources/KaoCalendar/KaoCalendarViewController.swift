//
//  KaoCalendarViewController.swift
//  KaoDesign
//
//  Created by Ramkrishna on 09/07/2019.
//

import UIKit
import AZYCalendarView

public class KaoCalendarViewController: KaoBottomSheetController {

    // MARK: - Var & Lets
    private lazy var calendarView: KaoCalenderView = {
        let calendarView = KaoCalenderView()
        calendarView.cancelTapped = cancelTapped
        calendarView.doneTapped = doneTapped
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        return calendarView
    }()

    // MARK: - Controller Lifecycle
    override public func viewDidLoad() {
        super.presentView = calendarView
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.presentViewHeight = self.view.frame.height * 0.75
        super.viewWillAppear(animated)
    }

    // MARK: - Callbacks
    private func cancelTapped() {
        self.dismissAnimation()
    }

    private func doneTapped(_ selectedDates: [Date]) {
        self.dismissAnimation()
    }
}

// MARK: - Extension
extension UIViewController {
    public func presentKaoCalendar() {
        let view = KaoCalendarViewController()
        view.modalPresentationStyle = .overFullScreen
        present(view, animated: false, completion: nil)
    }
}
