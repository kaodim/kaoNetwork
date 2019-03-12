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
        data.icon = UIImage(named: "img_downtime")
        data.title = NSAttributedString(string: "It’s not you, it’s us")
        data.message = NSAttributedString(string: "We are facing trouble loading articles. Please retry loading.")
        data.buttonTitle = "Retry"
        data.buttonDidTapped = retry
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

    private func configureLayout() {
        view.addSubview(internalServer)
        NSLayoutConstraint.activate([
            internalServer.topAnchor.constraint(equalTo: safeTopAnchor),
            internalServer.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            internalServer.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            internalServer.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])
    }
}

extension UIViewController {
    func presentInternalServerError(_ retry: (() -> Void)? = nil) {
        let view = InternalServerErrorViewController()
        view.retry = retry
        self.present(view, animated: true, completion: nil)
    }
}
