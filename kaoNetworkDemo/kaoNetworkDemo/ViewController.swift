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

public struct SampleLocation: Decodable {
    var language: String
    var text: String
}

public struct SampleLocationV2: Decodable {
    var id: String
    var source_url: String
}

public struct ImageUploadResponse: Decodable {
    var success: Bool
    var status: Int
}

//{"data":{"hashes":["4Yd1Rdv"],"hash":"4Yd1Rdv","deletehash":"7AzFIC224RQwsrf","ticket":false,"album":"rP6d7Kk","edit":false,"gallery":null,"poll":false,"animated":false,"height":557,"width":242,"ext":".png","msid":"856c951e35aed1a2fe674a9459e87a5a"},"success":true,"status":200}


//{"id":"fbdf16df-598a-4f6e-a34f-39959b5bf311","text":"Humans are the only primates that don`t have pigment in the palms of their hands.","source":"djtech.net","source_url":"http:\/\/www.djtech.net\/humor\/useless_facts.htm","language":"en","permalink":"https:\/\/uselessfacts.jsph.pl\/fbdf16df-598a-4f6e-a34f-39959b5bf311"}

public struct NetworkRequest<D: Decodable, E: ApprovedErrors>: KaoNetworkHandler {

    public typealias E = E

    public typealias D = D

    public static func printResponse(url: URL?, data: Data?) {
        print("===============[Response]=================")
        print("From Url: \(url?.absoluteString ?? "")")

        // #if Staging
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let payload = json as? [String: Any], !(payload.isEmpty) {
                    print(payload)
                }
            } catch {
                let str = String(data: data, encoding: .utf8)
                print(str)
            }
        }
        print("==========================================")
    }

    public static func printRequest(headers: HTTPHeaders, parameters: [String : Any]) {
        // #if Staging
        print("===============[Headers]==================")
        print(String(data: try! JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted), encoding: .utf8 ) ?? [:])
        print("===============[Parameters]===============")
        print(String(data: try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted), encoding: .utf8 ) ?? [:])
        print("==========================================")
    }

    public static func handleUnauthorized() {
        let topView = UIApplication.topViewController()
        let retryAction = (topView as? KaoNetworkProtocol)?.retry
        topView?.presentTimeOutError(retryAction)
    }

    public static func multipartDataHandler(formData: MultipartFormData, data: Data, fileName: String) {
        print("kelvin called")
        let fileNameString = fileName as NSString
        let fileExtension = fileNameString.pathExtension.lowercased()
        let mimeType = "image/png"

        formData.append(data, withName: "image", fileName: fileName, mimeType: mimeType)
    }
}

class ViewController: KaoBaseViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.retry = retryCallback
        super.viewDidLoad()
    }

    @IBAction func jsonConnectTapped() {

    }

    @IBAction func dataConnectTapped() {

//        if let url = URL(string: "https://uselessfacts.jsph.pl/random.json") {
        if let url = URL(string: "https://httpstat.us/\(textField.text ?? "")") {
            NetworkRequest<SampleLocationV2, BackendErrors>.request(url, method: .get, needAuth: false) { (result) in
                switch result {
                case .success(let smpl):
                    print(smpl)
                case .successButDecodeFail(let errMsg):
                    print(errMsg)
                case .failure(let sampl):
                    print(sampl.getAllMessage())
                case .failAndDecodeFail(let errMsg):
                    print(errMsg)
                case .failNoDataToDecode:
                    break
                }
            }
        }
    }

    @IBAction func uploadTapped() {
        let icon = UIImage.imageFromNetworkIos("img_waiting")
        if let data = icon?.compressedData(.low) {

            let header = ["Authorization": "Client-ID 546c25a59c58ad7"]

            NetworkRequest<ImageUploadResponse, BackendErrors>.uploadAttachment("https://api.imgur.com/3/upload", method: .post, header: header, attachmentData: data, fileName: "sasssss", progressHandler: { (progres) in
                print(progres)
            }) { (result) in
                switch result {
                case .success(let smpl):
                    print(smpl)
                case .successButDecodeFail(let errMsg):
                    print(errMsg)
                case .failure(let errMsg):
                    print(errMsg)
                }
            }
        }
    }

    @IBAction func noInternetTapped() {
        self.presentDisconnectScreen()
    }

    @IBAction func internalTapped() {
        self.presentInternalServerError()
    }

    @IBAction func timeOutTapped() {
        self.presentTimeOutError()
    }

    func retryCallback() {
        dismiss(animated: true, completion: nil)
        print("dont know what i am doing")
    }

    override func addNetworkErrorView(_ errorView: UIView) {
        
    }
}
