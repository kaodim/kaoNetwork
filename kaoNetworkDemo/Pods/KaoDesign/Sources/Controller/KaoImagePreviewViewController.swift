//
//  KaoImagePreviewViewController.swift
//  KaoDesign
//
//  Created by augustius cokroe on 01/03/2019.
//

import Foundation

final class KaoImagePreviewViewController: UIViewController, UIScrollViewDelegate {

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.minimumZoomScale = 1.0
        view.maximumZoomScale = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = .whiteLarge
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var url: String?
    private var image: UIImage?
    private var data: Data?

    init(imageURL: String? = nil, image: UIImage? = nil, data: Data? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.url = imageURL
        self.image = image
        self.data = data
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        setupImageView()
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapGestureHandler)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func configureLayout() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeTopAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeTrailingAnchor)
            ])

        scrollView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])

        scrollView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 37),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 37)
            ])

    }

    @objc private func imageTapGestureHandler() {
        if scrollView.zoomScale == 1.0 {
            dismiss(animated: true, completion: nil)
        } else {
            scrollView.zoomScale = 1.0
        }
    }

    private func setupImageView() {
        if let image = image {
            loadingIndicator.stopAnimating()
            photoImageView.image = image
        } else if let url = url {
            photoImageView.cache(withURL: url, placeholder: UIImage(), completion: { (_, _, _, _) in
                self.loadingIndicator.stopAnimating()
            })
        } else if let data = data, let image = UIImage.init(data: data) {
            loadingIndicator.stopAnimating()
            photoImageView.image = image
        } else {
            loadingIndicator.stopAnimating()
        }
    }

    // MARK: - UIScrollviewDelegate
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // Avoid dismissal on zooming mode
        guard (scrollView.zoomScale <= 1.0) else { return }

        if scrollView.contentOffset.y >= 100.0 {
            // Dismiss on scroll-up
            dismiss(animated: true, completion: nil)
        } else if scrollView.contentOffset.y <= -100.0 {
            // Dismiss on scroll-down
            dismiss(animated: true, completion: nil)
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}

