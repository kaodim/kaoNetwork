//
//  DateTimeManager.swift
//  Kaodim
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

public protocol DateTimeDelegate : class {
    func didSelect(date: DateTimeSurchargeDate?, time: SurchargeTime?)
}

import UIKit

public typealias DateTimeHandler = (_ date: DateTimeSurchargeDate?, _ time: SurchargeTime?) -> String

public class DateTimeManager {
    
    public static var handler: DateTimeHandler?
    
    public class func getController(_ json: String?) -> UIViewController? {
        do {
            guard let jsonWrapped    = json else { return nil }
            guard let rawData = jsonWrapped.data(using: .utf8) else { return nil }
            let decoder = try JSONDecoder().decode(DateTimeModel.self, from: rawData)
            let storyboard = UIStoryboard.StoryboardFromDesignIos("DateTime")
            let vc = storyboard.instantiateViewController(withIdentifier: "dateNavigation")
            if let nav = vc as? UINavigationController {
                if let viewController = nav.viewControllers.first as? DateTimeViewController {
                    viewController.dateModel     = decoder
                }
            }
            return vc
        } catch {}
        return nil
    }
    
}
