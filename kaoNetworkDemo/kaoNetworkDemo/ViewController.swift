//
//  ViewController.swift
//  kaoNetworkDemo
//
//  Created by Kelvin Tan on 3/5/19.
//  Copyright © 2019 Kaodim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KaoDesign
import kaoNetwork

public struct NetworkRequest: KaoNetworkErrorHandler {

    public static func handleUnauthorized() {
        print("showing unauthorized from network request")
    }

    public static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String) {
        print("kelvin called")
    }
}

class ViewController: KaoBaseViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func jsonConnectTapped() {
        if let url = URL(string: "https://httpstat.us/\(textField.text ?? "")") {
            NetworkRequest.requestJSON(url, method: .get, parameters: nil, headers: nil, showLoader: false) { (result) in

            }
        }
    }
    @IBAction func dataConnectTapped() {
        if let url = URL(string: "https://httpstat.us/\(textField.text ?? "")") {
            NetworkRequest.requestData(url, method: .get) { (data) in

            }
        }
    }

    @IBAction func uploadTapped() {
        let icon = UIImage.imageFromNetworkIos("img_waiting")
        if let data = icon?.compressedData(.low) {
            NetworkRequest.postMultiPart("https://api.imgur.com/3/image", header: [:], attachmentData: data, fileName: "jpg", progressHandler: { (progres) in
                print(progres)
            }) { (result) in
                switch result {
                case .success:
                    print("sucess")
                case .failure:
                    print("failure")
                }
            }
        }
    }

    @IBAction func noInternetTapped() {
        let view = DisconnectedViewController()
        self.present(view, animated: true, completion: nil)
    }

    @IBAction func internalTapped() {
        let view = InternalServerErrorViewController()
        self.present(view, animated: true, completion: nil)
    }

    @IBAction func timeOutTapped() {
        let view = TimeOutViewController()
        self.present(view, animated: true, completion: nil)
    }

    override func retry() {
        print("dont know what i am doing")
    }

    override func addNetworkErrorView(_ errorView: UIView) {
        
    }
}
