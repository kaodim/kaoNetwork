//
//  NoInternetView.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/8/19.
//

import Foundation
import UIKit
import KaoDesign

public class NoInternetView: UIView {

    @IBOutlet weak var contentView: KaoEmptyStateView!
//    private var contentView: UIView!
//    @IBOutlet private weak var imageView: UIImageView!
//    @IBOutlet weak var titleLabel: KaoLabel!
//    @IBOutlet weak var descriptionLabel: KaoLabel!
//    @IBOutlet weak var button: KaoButton!
//    var retry: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureView()
//        let data = 
//        contentView.configure(data)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configureView()
    }


//    private func loadFromNib() -> UIView {
//        let nib = UIView.nibFromKaoNetwork("NoInternetView")
//        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
//            fatalError("Nib not found.")
//        }
//        return view
//    }
//
//    func configureView() {
//        contentView = loadFromNib()
//        contentView.frame = bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(contentView)
//        titleLabel.font = UIFont.kaoFont(style: .medium, size: .large)
//        descriptionLabel.font = UIFont.kaoFont(style: .regular, size: .regular)
//        button.configure(type: .primary, size: .regular)
//    }
//
//    func configure(image: String, title: String, description: String, buttonTitle: String) {
//        imageView.image = UIImage(named: image)
//        titleLabel.text = title
//        descriptionLabel.text = description
//        button.setTitle(buttonTitle, for: .normal)
//    }
//
//    @IBAction func retryTapped() {
//        retry?()
//    }
}
