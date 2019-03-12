//
//  KaoLoadingIndicator.swift
//  KaoDesign
//
//  Created by augustius cokroe on 26/02/2019.
//

import Foundation
import SVProgressHUD

public class KaoLoading {

    public static let shared = KaoLoading()

    private var timer: Timer?

    public func show() {
        stopCountDown()
        startCountDown()
    }

    public func hide() {
        stopCountDown()
    }

    private func stopCountDown() {
        stopLoading()
        if let timer = timer {
            timer.invalidate()
        }
    }

    private func startCountDown() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(startLoading), userInfo: nil, repeats: false)
    }

    @objc private func startLoading() {
        let podBundle = Bundle(for: KaoLoading.self)
        let bundleURL = podBundle.url(forResource: "KaoCustomPod", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        if let asset = NSDataAsset(name: "kaodim_loader", bundle: bundle), let image = UIImage.gif(data: asset.data) {
            SVProgressHUD.setImageViewSize(CGSize(width: 80, height: 80))
            SVProgressHUD.setBackgroundColor(.white)
            SVProgressHUD.setMinimumDismissTimeInterval(60)
            SVProgressHUD.show(image, status: nil)
        } else {
            SVProgressHUD.show()
        }

        DispatchQueue.main.async(execute: {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.setRingThickness(0)
        })
    }

    @objc private func stopLoading() {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss(withDelay: 0.5)
        })
    }
}
