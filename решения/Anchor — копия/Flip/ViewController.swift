//
//  ViewController.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SpriteKit


extension CGFloat {
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}
extension CGFloat {
    var dp2: CGFloat {
        switch UIScreen.main.bounds.height {
        case 896, 812:
            return (self / 320) * UIScreen.main.bounds.width * 1.3
        case 736, 667:
            return (self / 320) * UIScreen.main.bounds.width * 1.1
        default:
            return (self / 320) * UIScreen.main.bounds.width
        }
    }
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

extension UILabel {
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
extension UILabel {
    func pulsateRep() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}


class ViewController: UIViewController {



    @IBOutlet weak var spinButton: UIButton!
    @IBAction func spinButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spin"), object: nil)
        spinButton.isEnabled = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "down"), object: nil)
    }
    
    
    @IBOutlet weak var fingerIGE: UIImageView!
    @IBOutlet weak var isoView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var result: UILabel! 
        
//        timer.invalidate()
//        isPlaying = false
//        counter = 0.0
//        sec.text = String(counter)
//
//        if(isPlaying) {
//            return
//        }
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
//        isPlaying = true
//    }
//    @objc func UpdateTimer() {
//        counter = counter + 0.1
//        sec.text = String(format: "%.1f", counter)
//    }
    
    @IBOutlet weak var sec: UILabel!
    @IBOutlet weak var flipUpView: FlipUp!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var spinPush: UIImageView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var isoLabel: UILabel!
    @IBAction func upButtonPush(_ sender: Any) {
        upButton.isSelected = true
        if downButton.isSelected == false {
        downButton.isEnabled = false
        downButton.isHidden = true
        upButton.isEnabled = false
        upButton.isHidden = true
        upLabel.pulsateRep()
        downLabel.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
            self.spinPush.isHidden = false
            self.upLabel.isHidden = true
      }
     }
    }
    @IBAction func downButtonPush(_ sender: Any) {
        downButton.isSelected = true
        if upButton.isSelected == false {
        upButton.isEnabled = false
        upButton.isHidden = true
        downButton.isEnabled = false
        downButton.isHidden = true
        downLabel.pulsateRep()
        upLabel.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
            self.spinPush.isHidden = false
            self.downLabel.isHidden = true
      }
     }
    }
    @objc func enableButton(){
        upButton.isEnabled = true
        downButton.isEnabled = true
        upButton.isHidden = false
        downButton.isHidden = false
        upLabel.isHidden = false
        downLabel.isHidden = false
    }
    func disableButtonStart(){
        upButton.isEnabled = false
        downButton.isEnabled = false
        upButton.isHidden = true
        downButton.isHidden = true
        spinButton.isEnabled = false
        spinButton.isHidden = true
        spinPush.isHidden = true
        upLabel.isHidden = true
        downLabel.isHidden = true
        isoLabel.isHidden = true
        fingerIGE.isHidden = true
    }

    @objc func enableSpinButton(){
        spinButton.isEnabled = true
        spinButton.isHidden = false
//        spinPush.isHidden = false
    }
//    var one = 0
//    var two = 0
//    var three = 0
//    var four = 0
//    var five = 0
//    var i = 1
    
    @objc func res() {
        result.text = UserDefaults.standard.string(forKey: "Result")
//        switch Int(UserDefaults.standard.string(forKey: "Result")!) {
//        case 1:
//            one += 1
//        case 2:
//            two += 1
//        case 3:
//            three += 1
//        case 4:
//            four += 1
//        case 5:
//            five += 1
//        default:
//            break
//        }
//        result.text = "\(one) \(two) \(three) \(four) \(five) \(i)"
//        if i != 300 {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spin"), object: nil)
//        spinButton.isEnabled = false
//            i += 1
//        }
    }
    
    

    
//    var counter = 0.0
//    var timer = Timer()
//    var isPlaying = false
//
//
//
//    @objc func res2() {
//        timer.invalidate()
//        isPlaying = false
//        spinButton.isEnabled = true
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sec.text = String(counter)
        let wS = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") / 2)
        var wS2 = CGFloat()
        switch screenHeight {
        case 896,812:
            wS2 = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") * 0.08 + 7)
        default:
            wS2 = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") * 0.08)
        }
        let wS3 = CGFloat(wS2 + (flipUpView.frame.height - wS) / 2)
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        self.isoView.translatesAutoresizingMaskIntoConstraints = false
        self.anchorView.translatesAutoresizingMaskIntoConstraints = false
        self.spinButton.translatesAutoresizingMaskIntoConstraints = false
        self.resultView.bottomAnchor.constraint(equalTo: self.resultView.superview!.bottomAnchor, constant: -wS).isActive = true
        self.isoView.topAnchor.constraint(equalTo: self.isoView.superview!.topAnchor, constant: wS).isActive = true
        self.anchorView.bottomAnchor.constraint(equalTo: self.anchorView.superview!.bottomAnchor, constant: wS2).isActive = true
        self.anchorView.heightAnchor.constraint(equalToConstant: wS3).isActive = true
        switch screenHeight {
        case 896,812:
            self.spinButton.topAnchor.constraint(equalTo: self.spinButton.superview!.topAnchor, constant: wS * 1.3).isActive = true
        default:
            self.spinButton.topAnchor.constraint(equalTo: self.spinButton.superview!.topAnchor, constant: wS * 1.23).isActive = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        let ert:CGFloat = 60
        let ert2:CGFloat = 40
            self.upLabel.font = self.upLabel.font.withSize(ert.dp)
            self.downLabel.font = self.downLabel.font.withSize(ert.dp)
            self.isoLabel.font = self.isoLabel.font.withSize(ert2.dp2)
        }
        
            self.disableButtonStart()
            NotificationCenter.default.addObserver(self, selector: #selector(self.enableButton), name: NSNotification.Name(rawValue: "resting"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.enableSpinButton), name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.res), name: NSNotification.Name(rawValue: "res"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.res2), name: NSNotification.Name(rawValue: "res2"), object: nil)
    }

}

