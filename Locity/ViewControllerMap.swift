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




class ViewControllerMap: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tornView: Torn!
    
    
    @objc func buttonEnable(){
        button.isHidden = false
        button.isEnabled = true
        tornView.isHidden = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
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
        print("deinitM")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isHidden = true
        button.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(buttonEnable), name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
