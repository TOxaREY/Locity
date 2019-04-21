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

    
   // @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tornView: Torn!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var topSupport: UILabel!
    @IBOutlet weak var bottomSupport: UILabel!
    
    func labelCheckMaxSizeFunc(fSize:CGFloat,labelName:UILabel,text:String) -> (CGFloat) {
        labelName.text = text
        var minFs = CGFloat()
        var bounds = labelName.bounds
        func checkSize(fS:CGFloat) {
            var fS = fS
            labelName.font = labelName.font.withSize(CGFloat(fS))
            bounds.size = labelName.intrinsicContentSize
                if bounds.size.width > labelName.frame.width {
                    fS -= 1
                    checkSize(fS: fS)
                } else {
                    labelName.text = ""
                    minFs = fS
            }
        }
        checkSize(fS: fSize)
        return minFs
    }
    
    func labelEffectAndCheckMaxSize(fSize:CGFloat,labelName:UILabel,sSize:CGFloat,nameSupport:UILabel,text:String){
        let fS = labelCheckMaxSizeFunc(fSize: fSize, labelName: labelName, text: text)
        let sup = labelCheckMaxSizeFunc(fSize: sSize, labelName: nameSupport, text: text)
        labelName.isHidden = false
        labelName.backgroundColor = .clear
        labelName.text = text
        var bounds = labelName.bounds
        labelName.font = labelName.font.withSize(fS)
        bounds.size = labelName.intrinsicContentSize
        labelName.bounds = bounds
        labelName.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 3.0, animations: {
            labelName.transform = .identity
            }, completion: { done in
                let transformSc = CGAffineTransform(scaleX: sup / fS, y: sup / fS)
                let transformTr = CGAffineTransform(translationX: 0, y: 250)
                UIView.animate(withDuration: 3.0, animations: {
                    labelName.transform = transformTr.concatenating(transformSc)
                    }, completion: { done in
                        print(fS)
                        print(sup)
                })
        })
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    @objc func buttonEnable(){
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.deinitComplete), userInfo: nil, repeats: true)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
//    }
//    @objc func deinitComplete(){
//        if deinitSKVWheelVCC && deinitSKVFTVCC && deinitSKVFBVCC && deinitSKVAnchorVCC && deinitSKVIsoViewRemoverVCC && deinitVCC {
//            timer.invalidate()
//            self.button.isHidden = false
//            self.button.isEnabled = true
//            print("enableButton")
//            self.tornView.isHidden = true
//        }
//    }
//
//    @IBAction func buttonEnableeee(_ sender: Any) {
//        round += 1
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newVC = sB.instantiateViewController(withIdentifier: "VCC")
//        appDel.window?.rootViewController = newVC
//        appDel.window?.makeKeyAndVisible()
//    }
//    deinit {
//        print("deinitVCM")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tornView.isHidden = false
        countryLabel.isHidden = true
        labelEffectAndCheckMaxSize(fSize: 40, labelName: countryLabel, sSize: 20, nameSupport: bottomSupport, text: "eewfewegwg")
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
  //      button.isHidden = true
 //       button.isEnabled = false
//        NotificationCenter.default.addObserver(self, selector: #selector(self.buttonEnable), name: NSNotification.Name(rawValue: "buttonEnable"), object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
