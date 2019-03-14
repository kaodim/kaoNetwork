//
//  TimeOutViewController.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/12/19.
//

import UIKit
import KaoDesign

public class TimeOutViewController: UIViewController {

    private lazy var timeOut: KaoEmptyStateView = {
        let view: KaoEmptyStateView = KaoEmptyStateView()
        var data = KaoEmptyState()
        data.topSpace = 100
        data.icon = UIImage.imageFromNetworkIos("img_waiting")
        data.title = NSAttributedString(string: "You were inactive for a while")
        data.message = NSAttributedString(string: "Your session ended due to inactivity. \n Please start over.")
        data.buttonTitle = "Start Over"
        data.buttonDidTapped = retryButtonTapped
        view.configure(data)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var retry: (() -> Void)?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureLayout()
    }

    public func retryButtonTapped() {
        if let retry = retry {
            retry()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func configureLayout() {
        view.addSubview(timeOut)
        NSLayoutConstraint.activate([
            timeOut.topAnchor.constraint(equalTo: safeTopAnchor),
            timeOut.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            timeOut.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            timeOut.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

extension UIViewController {
    public func presentTimeOutError(_ retry: (() -> Void)? = nil) {
        let view = TimeOutViewController()
        view.retry = retry
        self.present(view, animated: true, completion: nil)
    }
}
