//
//  ViewController.swift
//  Wheel
//
//  Created by REYNIKOV ANTON on 04/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

extension UIImageView {
    func pulsate() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}
   var whell = Wheel()
class ViewController: UIViewController {
    

    @IBOutlet weak var velo: UITextField!
    @IBOutlet weak var spinPush: UIImageView!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBAction func spinButton(_ sender: Any) {
        if velo.text != "" {
        UserDefaults.standard.set(velo.text, forKey: "velo")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spin"), object: nil)
        result.text = ""
        spinButton.isEnabled = false
//        spinPush.removeFromSuperview()
      }
    }
    @objc func res() {
        result.text = UserDefaults.standard.string(forKey: "Result")
        spinButton.isEnabled = true
        spinPush.pulsate()
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        spinPush.pulsate()
        NotificationCenter.default.addObserver(self, selector: #selector(res), name: NSNotification.Name(rawValue: "res"), object: nil)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}

