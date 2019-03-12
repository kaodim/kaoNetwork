//
//  KaoUploadOptionView.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/02/2019.
//

import Foundation

public typealias KaoUploadOptionViewData = (options: [KaoUploadOption], contentWidth: CGFloat)

public class KaoUploadOptionView: UIView {

    private let cellIdentifier = "KaoUploadOptionCell"
    private var collectionView: UICollectionView!
    private let minimumWidth: CGFloat = 94.5
    private var idealRatio: CGFloat = (74.5 / 94.5) // W / H
    private var idealWidth: CGFloat = 94.5
    public var idealHeight: CGFloat = 74.5
    public var data: KaoUploadOptionViewData = ([] ,0) {
        didSet {
            self.configureFinalSize()
            self.configureCollectionView()
        }
    }
    public var finalSizeConfigured: (() -> Void)? = nil

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: idealWidth, height: idealHeight)
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
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }

    private func configureFinalSize() {
        let totalCellWidth = idealWidth * CGFloat(data.options.count)
        let totalSpacingWidth = CGFloat(8.0) * CGFloat(data.options.count - 1)
        let totalWidthNecessary = totalCellWidth + totalSpacingWidth
        // if totalWidthNecessary is enough then increase item layout size
        if totalWidthNecessary < data.contentWidth {
            let widthAvailable = data.contentWidth - totalSpacingWidth
            let widthForEachItem = widthAvailable / CGFloat(data.options.count)
            self.idealWidth = widthForEachItem
            self.idealHeight = (widthForEachItem * idealRatio)
        }
        finalSizeConfigured?()
    }
}

extension KaoUploadOptionView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.options.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? KaoUploadOptionCell else {
            fatalError("Cell not found.")
        }

        let option = data.options[indexPath.item]
        cell.configure(option.type, text: option.text)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = data.options[indexPath.item]
        option.tapAction?()
    }
}
