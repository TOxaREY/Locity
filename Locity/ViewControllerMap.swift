//
//  ViewControllerMap.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 11/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SpriteKit
import SQLite


var timer: Timer!

class ViewControllerMap: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tornView: Torn!
    
    
    @objc func buttonEnable(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.deinitComplete), userInfo: nil, repeats: true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
    }
    @objc func deinitComplete(){
        if deinitSKVWheelVCC && deinitSKVFTVCC && deinitSKVFBVCC && deinitSKVAnchorVCC && deinitSKVIsoViewRemoverVCC && deinitVCC {
            timer.invalidate()
            self.button.isHidden = false
            self.button.isEnabled = true
            print("enableButton")
            self.tornView.isHidden = true
        }
    }
    
    @IBAction func buttonEnableeee(_ sender: Any) {
        round += 1
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCC")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
    
    
    
    
    deinit {
        print("deinitVCM")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tornView.isHidden = false
        button.isHidden = true
        button.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.buttonEnable), name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
