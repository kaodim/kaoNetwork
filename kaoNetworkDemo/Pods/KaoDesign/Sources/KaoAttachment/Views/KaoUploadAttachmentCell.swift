//
//  KaoUploadAttachmentCell.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/02/2019.
//

import Foundation

open class KaoUploadAttachmentCell: UICollectionViewCell {

    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var attachmentIcon: UIImageView!
    @IBOutlet private weak var pdfIcon: UIImageView!
    @IBOutlet private weak var filename: KaoLabel!
    @IBOutlet private weak var removeButton: UIButton!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var retryView: UIView!
    @IBOutlet private weak var failUploadLabel: KaoLabel!
    @IBOutlet private weak var retryLabel: KaoLabel!

    public var removeDidTap: (() -> Void)?
    public var retryUploading: ((_ tempAttachment: KaoTempAttachment) -> Void)?
    public var tempAttachment: KaoTempAttachment? {
        didSet {
            self.configureAttachment()
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        progressView.progress = 0
        filename.font = UIFont.kaoFont(style: .regular, size: .small)
        failUploadLabel.font = UIFont.kaoFont(style: .regular, size: .small)
        retryLabel.font = UIFont.kaoFont(style: .regular, size: .small)

        retryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(retryUpload)))
        retryView.isHidden = true
        borderView.addCornerRadius()
        borderView.addBorderLine(width: 1, color: UIColor.kaoColor(.silver))

        pdfIcon.image = UIImage.imageFromDesignIos("icon_file")
        removeButton.setImage(UIImage.imageFromDesignIos("ic_close_light"), for: .normal)
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        tempAttachment?.removeObserver(self, forKeyPath: "progress")
        tempAttachment?.removeObserver(self, forKeyPath: "progresState")
        progressView.progress = 0
    }

    // MARK: - IBAction method
    @IBAction private func removeTapped() {
        removeDidTap?()
    }

    @objc private func retryUpload() {
        guard let tempAttachment = tempAttachment else { return }
        retryView.isHidden = true
        progressView.progress = 0.0
        retryUploading?(tempAttachment)
    }

    // MARK: - Private method
    private func configureAttachment() {
        tempAttachment?.addObserver(self, forKeyPath: "progress", options: .new, context: nil)
        tempAttachment?.addObserver(self, forKeyPath: "progresState", options: .new, context: nil)
        configureProgressState()
        filename.text = tempAttachment?.fileName
        retryLabel.text = tempAttachment?.retryText
        failUploadLabel.text = tempAttachment?.failText
        configureAttachmentUI()
    }

    private func configureAttachmentUI() {
        if let image = tempAttachment?.content as? UIImage {
            updateImageAttachment(image)
        } else if let data = tempAttachment?.content as? Data, let image = UIImage.init(data: data) {
            updateImageAttachment(image)
        } else if let urlString = tempAttachment?.content as? String {
            attachmentIcon.cache(withURL: urlString, placeholder: nil) { (image, error, _, _) in
                self.updateImageAttachment(image)
            }
        } else {
            updateImageAttachment()
        }
    }

    private func updateImageAttachment(_ image: UIImage? = nil) {
        let imageExist = image != nil
        attachmentIcon.image = image
        attachmentIcon.isHidden = !imageExist
        filename.isHidden = imageExist
        pdfIcon.isHidden = imageExist
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "progress" {
            updateProgress()
        } else if keyPath == "progresState" {
            configureProgressState()
        }
    }

    private func updateProgress() {
        if let progress = tempAttachment?.progress, progress > 0.0 {
            updateProgress(progress)
        }
    }

    private func updateProgress(_ progress: Float) {
        progressView.progress = progress
        progressView.isHidden = !(progress < 1.0)
    }

    private func configureProgressState() {
        guard
            let rawValue = tempAttachment?.progresState,
            let state = KaoAttachmentProgress(rawValue: rawValue)
            else { return }

        switch state {
        case .inProgress:
            updateProgress()
        case .success:
            updateProgress(1.0)
        case .failure:
            updateProgress(1.0)
            retryView.isHidden = false
        }
    }
}
