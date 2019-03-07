//
//  ViewController.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
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

class ViewController: UIViewController {
    
    @IBOutlet weak var wheelView: UIView!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBAction func spinButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spin"), object: nil)
        spinButton.isEnabled = false
        spinPush.removeFromSuperview()
    }
    @IBOutlet weak var spinPush: UIImageView!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBAction func upButtonPush(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        disableButton()
        wheelView.isHidden = false
    }
    @IBAction func downButtonPush(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        disableButton()
        wheelView.isHidden = false
    }
    @objc func enableButton(){
        upButton.isEnabled = true
        downButton.isEnabled = true
        upButton.isHidden = false
        downButton.isHidden = false
    }
    func disableButton(){
        upButton.isEnabled = false
        downButton.isEnabled = false
        upButton.isHidden = true
        downButton.isHidden = true
        spinButton.isEnabled = false
        spinButton.isHidden = true
        spinPush.isHidden = true
    }
    @objc func enableSpinButton(){
        spinPush.pulsate()
        spinButton.isEnabled = true
        spinButton.isHidden = false
        spinPush.isHidden = false
    }
    @objc func res() {
        result.text = UserDefaults.standard.string(forKey: "Result")
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
       // wheelView.isHidden = true
        disableButton()
        NotificationCenter.default.addObserver(self, selector: #selector(enableButton), name: NSNotification.Name(rawValue: "resting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableSpinButton), name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(res), name: NSNotification.Name(rawValue: "res"), object: nil)
    }
}
