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
    
    var timer: Timer!
    let fontSize:CGFloat = 35
    let fontSize2:CGFloat = 25
    let fontSize3:CGFloat = 20
    var roundCity = Int()
    
    var country = ""
    var city = ""
    var rand = 0
    var rand2 = 0
    var dictionaryCities:Dictionary<Int,String> = [:]
    
    @IBOutlet weak var tornView: Torn!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var topSupport: UILabel!
    @IBOutlet weak var bottomSupport: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var roundCityLabel: UILabel!
    @IBAction func homeButton(_ sender: Any) {
        diff = ""
        round = 1
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCS")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var homeImage: UIImageView!
    
    
    func labelCheckMaxSizeFunc(fSize:CGFloat,labelName:UILabel,text:String) -> (CGFloat) {
        labelName.text = text
        var minFs = CGFloat()
        var bounds = labelName.bounds
        func checkSize(fS:CGFloat) {
            var fS = fS
            labelName.font = labelName.font.withSize(CGFloat(fS))
            bounds.size = labelName.intrinsicContentSize
                if bounds.size.width > labelName.frame.width {
                    fS -= 0.5
                    checkSize(fS: fS)
                } else {
                    minFs = fS
            }
        }
        checkSize(fS: fSize)
        return minFs
    }
    
    func labelEffectAndCheckMaxSize(fSize:CGFloat,labelName:UILabel,sSize:CGFloat,nameSupport:UILabel,text:String,time:Double){
        //шрифт у основного лейбла и суппорта должен быть одинаковый
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
                let scaleCalcul = sup / fS
                self.effectMove(labelName: labelName, scaleCalcul: scaleCalcul, nameSupport: nameSupport,time: time)
        })
    }
    
    func effectMove(labelName:UILabel,scaleCalcul:CGFloat,nameSupport:UILabel,time:Double){
        var finalCenter = CGPoint.zero
        let finalScale = scaleCalcul
        finalCenter.x = nameSupport.center.x
        finalCenter.y = nameSupport.center.y
        let containerCenter = labelName.center
        let deltaX = finalCenter.x - containerCenter.x
        let deltaY = finalCenter.y - containerCenter.y
        let scale = CGAffineTransform(scaleX: finalScale, y: finalScale)
        let translation = CGAffineTransform(translationX: deltaX, y: deltaY)
        UIView.animate(withDuration: time, animations: {
            labelName.transform = scale.concatenating(translation)
            }, completion: { done in
                if labelName == self.cityLabel {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "inHome"), object: nil)
                }
        })
    }

    @objc func inHome(){
        roundLabel.text = "\(round)/5"
        roundCityLabel.text = "\(roundCity)/3"
        pointsLabel.text = "999"
        roundLabel.isHidden = false
        roundCityLabel.isHidden = false
        pointsLabel.isHidden = false
        homeImage.isHidden = false
        bottomSupport.isHidden = false
        topSupport.isHidden = false
        countryLabel.isHidden = true
        cityLabel.isHidden = true
        roundCityLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        roundLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pointsLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        homeImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0) {
            self.roundCityLabel.transform = .identity
        }
        UIView.animate(withDuration: 1.0) {
            self.roundLabel.transform = .identity
        }
        UIView.animate(withDuration: 1.0) {
            self.pointsLabel.transform = .identity
        }
        UIView.animate(withDuration: 1.0) {
            self.homeImage.transform = .identity
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "inHome"), object: nil)
    }
    

    @objc func enableVCM(){
        selectCity(dic: dictionaryCities)
        self.labelEffectAndCheckMaxSize(fSize: self.fontSize.dfz2, labelName: self.countryLabel, sSize: self.fontSize2.dfz2, nameSupport: self.bottomSupport, text: country,time: 3.0)
        self.labelEffectAndCheckMaxSize(fSize: self.fontSize.dfz2, labelName: self.cityLabel, sSize: self.fontSize2.dfz2, nameSupport: self.topSupport, text: city,time: 3.0)
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.deinitComplete), userInfo: nil, repeats: true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableVCM"), object: nil)
    }
    @objc func deinitComplete(){
        if deinitSKVWheelVCC && deinitSKVFTVCC && deinitSKVFBVCC && deinitSKVAnchorVCC && deinitSKVIsoViewRemoverVCC && deinitVCC && deinitVCS {
            timer.invalidate()
            homeButtonOutlet.isHidden = false
            homeButtonOutlet.isEnabled = true
            print("enableButton")
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deinitComplete"), object: nil)
            
        }
    }
    func selectCity(dic:Dictionary<Int, String>) {
        let random = Int.random(in: 1...dic.count)
        if rand == random || rand2 == random {
            selectCity(dic: dic)
        } else {
            if rand == 0 {
            rand = random
            city = dic[random]!
            } else {
                if rand2 == 0 {
                    rand2 = random
                    city = dic[random]!
                } else {
                    city = dic[random]!
                }
            }
        }
    }
    
    
    deinit {
        print("deinitVCM")
        deinitVCM = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        round = 1
        roundCity = 1
        idSelectCountry = 20
        
        do {
            for idSelect in try base.database.prepare(base.countriesTable.select(base.country).filter(base.id == idSelectCountry)){
                country = idSelect[base.country]
            }
        } catch {
            print(error)
        }
        do {
            var c = 1
            for city in try base.database.prepare(base.citiesTable.select(base.city).filter(base.id_country == idSelectCountry)){
                dictionaryCities[c] = city[base.city]
                c += 1
            }
        } catch {
            print(error)
        }
        
        homeButtonOutlet.isHidden = true
        homeButtonOutlet.isEnabled = false
        homeImage.image = UIImage(named: "home.png")
        homeImage.isHidden = true
        tornView.isHidden = false
        topSupport.isHidden = true
        bottomSupport.isHidden = true
        countryLabel.isHidden = true
        roundLabel.isHidden = true
        roundCityLabel.isHidden = true
        pointsLabel.isHidden = true
        pointsLabel.font = self.pointsLabel.font.withSize(self.fontSize3.dfz2)
        roundLabel.font = self.roundLabel.font.withSize(self.fontSize2.dfz2)
        roundCityLabel.font = self.roundCityLabel.font.withSize(self.fontSize2.dfz2)
        let effectView = UIVisualEffectView()
        effectView.frame = blurView.bounds
        effectView.effect = UIBlurEffect(style: .regular)
        blurView.addSubview(effectView)
        UIView.animate(withDuration: 6, animations: {
                effectView.effect = nil
            })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.inHome), name: NSNotification.Name(rawValue: "inHome"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableVCM), name: NSNotification.Name(rawValue: "enableVCM"), object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
