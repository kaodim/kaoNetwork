//
//  KaoTempAttachment.swift
//  KaoDesign
//
//  Created by augustius cokroe on 12/02/2019.
//

import Foundation

public enum KaoAttachmentProgress: Int {
    case inProgress = 0
    case success = 200
    case failure = 404
}

open class KaoTempAttachment: NSObject {
    public let fileName: String
    public let content: AnyObject
    public var fileId: String?
    @objc dynamic public var progresState: KaoAttachmentProgress.RawValue = -1
    @objc dynamic public var progress: Float = 0.0
    public var retryText: String? = nil
    public var failText: String? = nil

    public init(fileName: String, content: AnyObject, fileId: String? = nil, state: KaoAttachmentProgress.RawValue = KaoAttachmentProgress.inProgress.rawValue) {
        self.fileName = fileName
        self.content = content
        self.fileId = fileId
        self.progresState = state
    }

    public func getContentData() -> Data {
        let data: Data
        if let image = self.content as? UIImage, let imageData = image.compressedData(.lowest) {
            data = imageData
        } else if let fileURL = self.content as? URL, let fileData = try? Data(contentsOf: fileURL) {
            data = fileData
        } else if let contentData = self.content as? Data {
            data = contentData
        } else {
            data = Data()
        }

        return data
    }
}
