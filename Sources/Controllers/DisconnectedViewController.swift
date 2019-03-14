//
//  DisconnectedViewController.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/11/19.
//

import Foundation
import KaoDesign
import Alamofire

public class DisconnectedViewController: UIViewController {

    private lazy var noInternet: KaoEmptyStateView = {
        let view: KaoEmptyStateView = KaoEmptyStateView()
        var data = KaoEmptyState()
        data.icon = UIImage.imageFromNetworkIos("img_nointernet")
        data.title = NSAttributedString(string: "Looks like we lost you!")
        data.message = NSAttributedString(string: "Please make sure you are connected to the internet to proceed.")
        data.buttonTitle = "Retry"f
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
        if (NetworkReachabilityManager(host: "www.apple.com")!.isReachable) {
            self.dismiss(animated: true, completion: nil)
        } else {
            if let retry = retry {
                retry()
            }
        }
    }

    private func configureLayout() {
        view.addSubview(noInternet)
        NSLayoutConstraint.activate([
            noInternet.topAnchor.constraint(equalTo: safeTopAnchor),
            noInternet.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            noInternet.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            noInternet.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

extension UIViewController {
    func presentDisconnectScreen(_ retry: (() -> Void)? = nil) {
        let view = DisconnectedViewController()
        view.retry = retry
        self.present(view, animated: true, completion: nil)
    }
}
