//
//  KaoUploadOption.swift
//  KaoDesign
//
//  Created by augustius cokroe on 13/02/2019.
//

import Foundation

public enum KaoAttachmentType {
    case camera
    case library
    case document

    func imageName() -> UIImage? {
        switch self {
        case .camera:
            return UIImage.imageFromDesignIos("icon_camera")
        case .library:
            return UIImage.imageFromDesignIos("icon_library")
        case .document:
            return UIImage.imageFromDesignIos("icon_doc")
        }
    }
}

public struct KaoUploadOption {
    public let type: KaoAttachmentType
    public let text: String
    public let tapAction: (() -> Void)?

    public init(_ type: KaoAttachmentType, text: String, tapAction: (() -> Void)?) {
        self.type = type
        self.text = text
        self.tapAction = tapAction
    }
}
