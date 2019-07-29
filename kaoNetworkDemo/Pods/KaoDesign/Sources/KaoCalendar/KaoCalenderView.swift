//
//  KaoCalenderView.swift
//  KaoDesign
//
//  Created by Ramkrishna on 09/07/2019.
//

import UIKit
import AZYCalendarView

class KaoCalenderView: UIView {

    // MARK: - Var & Lets
    private var containerView: UIView!

    @IBOutlet private weak var calendarView: UIView!
    @IBOutlet private weak var weekTitleView: UIView!
    @IBOutlet private weak var doneBtn: UIButton!

    @IBOutlet private weak var startDateTitle: UILabel!
    @IBOutlet private weak var endDateTitle: UILabel!

    @IBOutlet private weak var startDate: UILabel!
    @IBOutlet private weak var endDate: UILabel!

    @IBOutlet private weak var startMonthTitle: UILabel!
    @IBOutlet private weak var endMonthTitle: UILabel!

    @IBOutlet private weak var startDayTitle: UILabel!
    @IBOutlet private weak var endDayTitle: UILabel!

    @IBOutlet private weak var startSelectDate: UILabel!
    @IBOutlet private weak var endSelectDate: UILabel!

    @IBOutlet private weak var startDateView: UIView!
    @IBOutlet private weak var endDateView: UIView!

    private var selectedDates = [Date]()


    public var cancelTapped: (() -> Void)?
    public var doneTapped: ((_ selectedDates: [Date]) -> Void)?

    // MARK: - init methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    // MARK: - Setup UI
    private func setupViews() {
        containerView = loadViewFromNib()
        containerView.frame = frame
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupUI()
        setupCalendarView()
        addSubview(containerView)
    }

    private func setupUI() {
        startDateView.isHidden = true
        startDateTitle.text = "Start date"
        startDateTitle.textColor = UIColor.kaoColor(.crimson)
        startSelectDate.text = "Select start date"

        resetEndDate()
    }

    private func loadViewFromNib() -> UIView {
        let nib = UIView.nibFromDesignIos("KaoCalenderView")
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }


    private func setupCalendarView() {

        doneBtn.isEnabled = false

        let screenWidth = UIScreen.main.bounds.width
        let weekView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: weekTitleView.frame.height))
        self.weekTitleView.addSubview(weekView)

        let weekWidth = screenWidth / 7

        let titles = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        for i in 0..<7 {
            let week = UILabel(frame: CGRect(x: CGFloat(CGFloat(i) * weekWidth), y: 0, width: weekWidth, height: 44))
            week.textAlignment = .center
            weekView.addSubview(week)
            week.textColor = UIColor.kaoColor(.dustyGray2)
            week.font = UIFont.kaoFont(style: .semibold, size: 13)
            week.text = titles[i]
        }

        let calendarframe = calendarView.frame
        let frame = CGRect.init(x: calendarframe.x, y: calendarframe.y, width: screenWidth, height: calendarframe.size.height)

        let view = ZYCalendarView.init(frame: frame)
        view.manager.canSelectPastDays = true
        view.manager.canSelectFutureDays = false
        view.manager.selectionType = .range
        view.manager.selectedBackgroundColor = UIColor .kaoColor(.crimson)
        view.date = Date()
        view.dayViewBlock = dayViewCallBack

        self.calendarView.addSubview(view)
    }

    private func updateDateView(isStart: Bool, date: Date) {
        if isStart {
            startDateTitle.textColor = UIColor.kaoColor(.black)
            startDateView.isHidden = false
            startSelectDate.isHidden = true
            startDate.text = date.toString("d")
            startDayTitle.text = date.toString("EEEE")
            startMonthTitle.text = date.toString("MMM YYYY")
        } else {
            endDateTitle.textColor = UIColor.kaoColor(.black)
            endDateView.isHidden = false
            endSelectDate.isHidden = true
            endDate.text = date.toString("d")
            endDayTitle.text = date.toString("EEEE")
            endMonthTitle.text = date.toString("MMM YYYY")
        }
    }

    private func resetEndDate() {
        endDateView.isHidden = true
        endSelectDate.isHidden = false
        endDateTitle.text = "End date"
        endSelectDate.text = "Select end date"
        endDateTitle.textColor = UIColor.kaoColor(.crimson)
    }

    private func updateDoneBtn(_ isEnabled: Bool) {
        self.doneBtn.isEnabled = isEnabled
    }

    // MARK: - Callbacks
    private func dayViewCallBack(manager: ZYCalendarManager?, dayDate: Any?) {
        if manager?.selectedDateArray.count == 1 {
            if let startDate = manager?.selectedDateArray.firstObject as? Date {
                updateDateView(isStart: true, date: startDate)
                selectedDates.insert(startDate, at: 0)
            }
            resetEndDate()
            updateDoneBtn(false)
        } else if manager?.selectedDateArray.count == 2 {
            if let endDate = manager?.selectedDateArray[1] as? Date {
                updateDateView(isStart: false, date: endDate)
                selectedDates.insert(endDate, at: 1)
            }
            updateDoneBtn(true)
        } else {
            selectedDates.removeAll()
        }
    }


    // MARK: - Actions
    @IBAction func closeTapped(_ sender: Any) {
        cancelTapped?()
    }

    @IBAction func doneTapped(_ sender: Any) {
        print("Tapped")
        doneTapped?(selectedDates)
    }
}
