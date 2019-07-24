//
//  KaoPresenterViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 01/03/2019.
//

import Foundation

open class KaoPresenterViewController: UIViewController {

    public var presentView: UIView!

    private lazy var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.kaoColor(.black, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var presentViewCenter: NSLayoutConstraint!
    private var initialPointX: CGFloat = UIScreen.main.bounds.height / 5

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureLayout()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }

    private func startAnimation() {
        presentView.alpha = 0
        blurView.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
        }) { (_) in
            self.presentViewCenter.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.presentView.alpha = 1
                self.blurView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }

    public func dismissAnimation(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.presentViewCenter.constant = self.initialPointX
            self.presentView.alpha = 0
            self.blurView.alpha = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
        }) { (_) in
            self.dismiss(animated: false, completion: {
                completion?()
            })
        }
    }

    private func configureLayout() {
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            blurView.topAnchor.constraint(equalTo: safeTopAnchor, constant: -100),
            blurView.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: 100)
            ])

        presentViewCenter = presentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        presentViewCenter.constant = initialPointX
        view.addSubview(presentView)
        NSLayoutConstraint.activate([
            presentView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            presentView.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            presentViewCenter,
            presentView.bottomAnchor.constraint(equalTo: safeBottomAnchor)
            ])
    }
}
