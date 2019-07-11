//
//  RateManager.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/07/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import StoreKit
@available(iOS 10.3, *)
class RateManager {
    class func incrementCount() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        print("Rate \(count)")
        if count < 3 {
            UserDefaults.standard.set(count + 1, forKey: "run_count")
            UserDefaults.standard.synchronize()
        }
    }
    
    class func showRatesController () {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        if count == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                SKStoreReviewController.requestReview()
            })
        }
    }
}
