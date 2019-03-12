//
//  UIViewController+Permission.swift
//  KaoDesign
//
//  Created by augustius cokroe on 01/03/2019.
//

import Foundation
import Photos

public extension UIViewController {

    func checkCameraPermission(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?, permissionDenied: @escaping (() -> Void)) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (status) in
            if status {
                self.openCamera(delegate)
            } else {
                permissionDenied()
            }
        }
    }

    func openCamera(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = delegate
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("This device doesn't support camera access")
        }
    }

    func checkPhotoLibraryPermission(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?, permissionDenied: @escaping (() -> Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.openPhotoLibrary(delegate)
        case .denied, .restricted :
            permissionDenied()
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.openPhotoLibrary(delegate)
                case .denied, .restricted, .notDetermined:
                    permissionDenied()
                }
            }
        }
    }

    func openPhotoLibrary(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = delegate
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("This device doesn't support photo library access")
        }
    }

    func openFileImporter(_ delegate: UIDocumentMenuDelegate) {
        let documentMenu = UIDocumentMenuViewController(documentTypes: ["public.content"], in: .import)
        documentMenu.delegate = delegate
        present(documentMenu, animated: true, completion: nil)
    }
}
