//
//  KaoUploadAttacmentView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/02/2019.
//

import Foundation

public class KaoUploadAttachmentView: UIView {

    private let cellIdentifier = "KaoUploadAttachmentCell"
    private var collectionView: UICollectionView!
    public var idealHeight: CGFloat = 150
    public var list: [KaoTempAttachment] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    public var attachmentDidRemove: ((_ index: Int) -> Void)?
    public var attachmentIconDidTap: ((_ index: Int) -> Void)?
    public var retryUploading: ((_ attachment: KaoTempAttachment) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 205, height: idealHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 8.0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView.init(frame: bounds, collectionViewLayout: layout)
        collectionView.register(UIView.nibFromDesignIos(cellIdentifier), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
}

extension KaoUploadAttachmentView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? KaoUploadAttachmentCell else {
            fatalError("Cell not found.")
        }

        let tempAttachment = list[indexPath.item]
        cell.removeDidTap = {
            self.attachmentDidRemove?(indexPath.row)
        }
        cell.retryUploading = retryUploading
        cell.tempAttachment = tempAttachment
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        attachmentIconDidTap?(indexPath.row)
    }
}
