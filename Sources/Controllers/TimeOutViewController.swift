//
//  TimeOutViewController.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/12/19.
//

import UIKit
import KaoDesign
import Alamofire

public class TimeOutViewController: KaoBaseViewController {

    private lazy var timeOut: KaoEmptyStateView = {
        let view: KaoEmptyStateView = KaoEmptyStateView()
        var data = KaoEmptyState()
        data.icon = UIImage.imageFromNetworkIos("img_waiting")
        data.title = NSAttributedString(string: "You were inactive for a while")
        data.message = NSAttributedString(string: "Your session ended due to inactivity. \n Please start over.")
        data.buttonTitle = "Start Over"
        data.buttonDidTapped = retryButtonTapped
        view.configure(data)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureLayout()
    }

    public func retryButtonTapped() {
        if (NetworkReachabilityManager(host: "www.apple.com")!.isReachable) {
            if let retry = retry {
                retry()
            } else {
                 self.dismiss(animated: true, completion: nil)
            }
        }
    }

    private func configureLayout() {
        view.addSubview(timeOut)
        NSLayoutConstraint.activate([
            timeOut.topAnchor.constraint(greaterThanOrEqualTo: safeTopAnchor, constant: 0),
            timeOut.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            timeOut.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            timeOut.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

public extension UIViewController {
    func presentTimeOutError(_ retry: (() -> Void)? = nil) {
        if !self.isKind(of: TimeOutViewController.self) {
            let view = TimeOutViewController()
            view.retry = retry
            view.modalPresentationStyle = .overFullScreen
            self.present(view, animated: true, completion: nil)
        }
    }
}
