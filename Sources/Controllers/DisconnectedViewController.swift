//
//  DisconnectedViewController.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/11/19.
//

import Foundation
import KaoDesign
import Alamofire

public class DisconnectedViewController: KaoBaseViewController {

    private lazy var noInternet: KaoEmptyStateView = {
        let view: KaoEmptyStateView = KaoEmptyStateView()
        var data = KaoEmptyState()
        data.icon = UIImage.imageFromNetworkIos("img_nointernet")
        data.title = NSAttributedString(string: "Looks like we lost you!")
        data.message = NSAttributedString(string: "Please make sure you are connected to the internet to proceed.")
        data.buttonTitle = "Retry"
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
        view.addSubview(noInternet)
        NSLayoutConstraint.activate([
            noInternet.topAnchor.constraint(greaterThanOrEqualTo: safeTopAnchor, constant: 0),
            noInternet.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            noInternet.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            noInternet.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

public extension UIViewController {
    func presentDisconnectScreen(_ retry: (() -> Void)? = nil) {
        if !self.isKind(of: DisconnectedViewController.self) {
            let view = DisconnectedViewController()
            view.retry = retry
            view.modalPresentationStyle = .overFullScreen
            self.present(view, animated: true, completion: nil)
        }
    }
}
