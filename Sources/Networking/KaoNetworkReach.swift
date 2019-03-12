//
//  KaoNetworkReach.swift
//  kaoNetwork
//
//  Created by Kelvin Tan on 3/7/19.
//

import Foundation
import Alamofire
import KaoDesign

public class KaoNetworkReach {

    public static let shared = KaoNetworkReach()

    let manager = NetworkReachabilityManager(host: "www.apple.com")

    public func startObserve() {
        manager?.listener = { status in
            switch status {
            case .notReachable:
                self.presentNoInternetScreen()
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
            }
        }
        self.manager?.startListening()
    }

    public func stopObserve() {
        self.manager?.stopListening()
    }

    func presentNoInternetScreen() {
        let topView = UIApplication.topViewController()
        let retryAction = (topView as? KaoNetworkProtocol)?.retry
        topView?.presentDisconnectScreen(retryAction)
    }
}
