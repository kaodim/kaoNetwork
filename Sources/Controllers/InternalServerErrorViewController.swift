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
        data.buttonDidTapped = { self.dismiss(animated: true, completion: nil) }
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
