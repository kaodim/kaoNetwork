//
//  KaoBottomSheetController.swift
//  KaoDesign
//
//  Created by Augustius on 19/06/2019.
//

import Foundation

open class KaoBottomSheetController: UIViewController {

    public var presentView: UIView!
    public var presentViewHeight: CGFloat = 0
    public var maxPresentHeight: CGFloat = UIScreen.main.bounds.height * 0.8
    public var bottomOffset: CGFloat = 100

    private lazy var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.kaoColor(.black, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    private var presentViewTop: NSLayoutConstraint!
    private var initialTop: CGFloat = 0

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAnimate))
        blurView.addGestureRecognizer(tapGesture)
        configureLayout()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blurView.alpha = 1
        startAnimation()
    }

    public func startAnimation() {
        let finalHeight = maxPresentHeight > presentViewHeight ? presentViewHeight : maxPresentHeight
        UIView.animate(withDuration: 0.2, animations: {
        }) { (_) in
            self.presentViewTop.constant = -finalHeight
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc private func dismissAnimate() {
        dismissAnimation()
    }

    public func dismissAnimation(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.presentViewTop.constant = self.initialTop
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

        presentViewTop = presentView.topAnchor.constraint(equalTo: safeBottomAnchor)
        presentViewTop.constant = self.initialTop

        presentView.addCornerRadius(8)
        view.addSubview(presentView)
        NSLayoutConstraint.activate([
            presentView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            presentView.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            presentViewTop,
            presentView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
            ])
    }
}
