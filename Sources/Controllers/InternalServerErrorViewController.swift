//
//  InternalServerErrorViewController.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/11/19.
//

import Foundation
import KaoDesign

public class InternalServerErrorViewController: UIViewController {

    private lazy var internalServer: KaoEmptyStateView = {
        let view: KaoEmptyStateView = KaoEmptyStateView()
        var data = KaoEmptyState()
        data.icon = UIImage.imageFromNetworkIos("img_downtime")
        data.title = NSAttributedString(string: "Kaodim is facing server downtime")
        data.message = NSAttributedString(string: "Please bear with us while we work to resolve this.")
        data.buttonTitle = "Close"
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
        view.addSubview(internalServer)
        NSLayoutConstraint.activate([
            internalServer.topAnchor.constraint(greaterThanOrEqualTo: safeTopAnchor, constant: 0),
            internalServer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            internalServer.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            internalServer.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

public extension UIViewController {
    func presentInternalServerError(_ retry: (() -> Void)? = nil) {
        if !self.isKind(of: InternalServerErrorViewController.self) {
            let view = InternalServerErrorViewController()
            view.retry = retry
            self.present(view, animated: true, completion: nil)
        }
    }
}
