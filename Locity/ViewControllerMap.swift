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

public var cityX = CGFloat()
public var cityY = CGFloat()
public var city2X = CGFloat()
public var city2Y = CGFloat()
public var city3X = CGFloat()
public var city3Y = CGFloat()

class ViewControllerMap: UIViewController {
    
    var timer: Timer!
    let fontSize:CGFloat = 35
    let fontSize2:CGFloat = 25
    let fontSize3:CGFloat = 20
    var roundCity = 1
    
    var country = ""
    var city = ""
    var city2 = ""
    var city3 = ""
    var rand = 0
    var rand2 = 0
    var rand3 = 0
    var randSupport = 0
    var dictionaryCities:Dictionary<Int,String> = [:]
    var boundStartCity = CGRect()
    var boundStartCountry = CGRect()
    var coordinatesTouch = CGPoint.zero
    var goTouch = Bool()
    
    @IBOutlet weak var mapViewTouch: Map!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var topFlapLabel: UILabel!
    @IBOutlet weak var bottomFlapLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var topSupport: UILabel!
    @IBOutlet weak var bottomSupport: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var roundCityLabel: UILabel!
    @IBAction func homeButton(_ sender: Any) {
//        diff = ""
//        round = 1
        roundCity += 1
        startVCM()
        startLabelVCM()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetCitys"), object: nil)
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newVC = sB.instantiateViewController(withIdentifier: "VCS")
//        appDel.window?.rootViewController = newVC
//        appDel.window?.makeKeyAndVisible()
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
        if labelName == self.cityLabel {
            boundStartCity = labelName.bounds
        } else {
            boundStartCountry = labelName.bounds
        }
        var bounds = labelName.bounds
        labelName.font = labelName.font.withSize(fS)
        bounds.size = labelName.intrinsicContentSize
        labelName.bounds = bounds
        labelName.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: time, animations: {
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
                labelName.transform = .identity
                if labelName == self.cityLabel {
                    labelName.bounds = self.boundStartCity
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "transComplete"), object: nil)
                } else {
                    labelName.bounds = self.boundStartCountry
                }
        })
    }

    @objc func transComplete(){
        roundLabel.text = "\(round)/5"
        roundCityLabel.text = "\(roundCity)/3"
        roundLabel.isHidden = false
        roundCityLabel.isHidden = false
        pointsLabel.isHidden = false
        homeImage.isHidden = false
        bottomSupport.isHidden = false
        topSupport.isHidden = false
        countryLabel.isHidden = true
        cityLabel.isHidden = true
        topFlapLabel.isHidden = false
        bottomFlapLabel.isHidden = false
        goTouch = true
        topFlapLabel.transform = CGAffineTransform(scaleX: 0.1, y: 1)
        bottomFlapLabel.transform = CGAffineTransform(scaleX: 0.1, y: 1)
        roundCityLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        roundLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pointsLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        homeImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5) {
            self.roundCityLabel.transform = .identity
            self.roundLabel.transform = .identity
            self.pointsLabel.transform = .identity
            self.homeImage.transform = .identity
            self.topFlapLabel.transform = .identity
            self.bottomFlapLabel.transform = .identity
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addCitys"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "transComplete"), object: nil)
    }
    

    @objc func enableVCM(){
        startLabelVCM()
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
    func startLabelVCM(){
        if diff == "H" {
            self.selectCityHard(dic: self.dictionaryCities)
        } else {
            self.selectCityEasy(dic: self.dictionaryCities)
        }
            self.labelEffectAndCheckMaxSize(fSize: self.fontSize.dfz2, labelName: self.countryLabel, sSize: self.fontSize2.dfz2, nameSupport: self.bottomSupport, text: self.country,time: 2.0)
            self.labelEffectAndCheckMaxSize(fSize: self.fontSize.dfz2, labelName: self.cityLabel, sSize: self.fontSize2.dfz2, nameSupport: self.topSupport, text: self.city,time: 2.0)
    }
    func coordinate(cityName:String,cityXz:CGFloat,cityYz:CGFloat){
        switch cityXz {
        case cityX:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    cityX = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            }
        case city2X:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    city2X = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            }
        case city3X:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    city3X = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            }
        default:
            break
        }
        switch cityYz {
        case cityY:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == cityName)){
                    cityY = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
        case city2Y:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == cityName)){
                    city2Y = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
        case city3Y:
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == cityName)){
                    city3Y = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
        default:
            break
        }
    }
    func selectCityHard(dic:Dictionary<Int, String>) {
        let random = Int.random(in: 1...dic.count)
        if rand == random || rand2 == random {
            selectCityHard(dic: dic)
            } else {
                if rand == 0 {
                    rand = random
                    city = dic[random]!
                    print("c: \(city)")
                } else {
                    if rand2 == 0 {
                        rand2 = random
                        city = dic[random]!
                        print("c: \(city)")
                    } else {
                        city = dic[random]!
                        rand3 = random
                        print("c: \(city)")
                    }
            }
        }
    }
    func selectCityEasy(dic:Dictionary<Int, String>) {
        let random = Int.random(in: 1...dic.count)
        if rand == random || rand2 == random {
            selectCityEasy(dic: dic)
        } else {
            if rand == 0 {
                rand = random
                city = dic[random]!
                print("c: \(city)")
                coordinate(cityName: city, cityXz: cityX, cityYz: cityY)
                randomFuncCity(dic: dic)
            } else {
                if rand2 == 0 {
                    rand2 = random
                    city = dic[random]!
                    print("c: \(city)")
                    coordinate(cityName: city, cityXz: cityX, cityYz: cityY)
                    randomFuncCity(dic: dic)
                } else {
                    city = dic[random]!
                    rand3 = random
                    print("c: \(city)")
                    coordinate(cityName: city, cityXz: cityX, cityYz: cityY)
                    randomFuncCity(dic: dic)
                }
            }
        }
    }
    func randomFuncCity(dic:Dictionary<Int, String>) {
        let random = Int.random(in: 1...dic.count)
        if random == rand || random == rand2 || random == rand3 || random == randSupport {
            randomFuncCity(dic: dic)
        } else {
            if randSupport == 0 {
                city2 = dic[random]!
                print("c2: \(city2)")
                coordinate(cityName: city2, cityXz: city2X, cityYz: city2Y)
                randSupport = random
                randomFuncCity(dic: dic)
            } else {
                city3 = dic[random]!
                print("c3: \(city3)")
                coordinate(cityName: city3, cityXz: city3X, cityYz: city3Y)
                randSupport = 0
            }
        }
    }
    func startVCM(){
//        homeButtonOutlet.isHidden = true
//        homeButtonOutlet.isEnabled = false
        homeButtonOutlet.isHidden = false
        homeButtonOutlet.isEnabled = true
        homeImage.image = UIImage(named: "home.png")
        homeImage.isHidden = true
        topSupport.isHidden = true
        bottomSupport.isHidden = true
        bottomFlapLabel.isHidden = true
        topFlapLabel.isHidden = true
        countryLabel.isHidden = true
        cityLabel.isHidden = true
        roundLabel.isHidden = true
        roundCityLabel.isHidden = true
        pointsLabel.isHidden = true
        pointsLabel.font = self.pointsLabel.font.withSize(self.fontSize3.dfz2)
        roundLabel.font = self.roundLabel.font.withSize(self.fontSize2.dfz2)
        roundCityLabel.font = self.roundCityLabel.font.withSize(self.fontSize2.dfz2)
        goTouch = false
        let effectView = UIVisualEffectView()
        effectView.frame = blurView.bounds
        effectView.effect = UIBlurEffect(style: .regular)
        blurView.addSubview(effectView)
        UIView.animate(withDuration: 4, animations: {
            effectView.effect = nil
        })
        NotificationCenter.default.addObserver(self, selector: #selector(self.transComplete), name: NSNotification.Name(rawValue: "transComplete"), object: nil)
    }
    
    deinit {
        print("deinitVCM")
        deinitVCM = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        round = 1
        idSelectCountry = 20
        diff = "E"
        
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
        do {
            for image in try base.database.prepare(base.countriesTable.select(base.map).filter(base.id == idSelectCountry)){
                mapImage.image = UIImage(named:image[base.map])
            }
        } catch {
            print(error)
        }
        
        pointsLabel.text = "0"
        startVCM()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableVCM), name: NSNotification.Name(rawValue: "enableVCM"), object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if goTouch {
                let ringSize = CGFloat(UserDefaults.standard.double(forKey: "ringSize")) * 2.5
                let cityCoorX = CGFloat(UserDefaults.standard.double(forKey: "cityX"))
                let cityCoorY = CGFloat(UserDefaults.standard.double(forKey: "cityY"))
                let city2CoorX = CGFloat(UserDefaults.standard.double(forKey: "city2X"))
                let city2CoorY = CGFloat(UserDefaults.standard.double(forKey: "city2Y"))
                let city3CoorX = CGFloat(UserDefaults.standard.double(forKey: "city3X"))
                let city3CoorY = CGFloat(UserDefaults.standard.double(forKey: "city3Y"))
                coordinatesTouch = touch.location(in: mapViewTouch)
                coordinatesTouch.y = mapViewTouch.frame.height - self.coordinatesTouch.y
                if coordinatesTouch.x <= cityCoorX + ringSize && coordinatesTouch.x >= cityCoorX - ringSize &&
                    coordinatesTouch.y <= cityCoorY + ringSize && coordinatesTouch.y >= cityCoorY - ringSize {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesRight"), object: nil)
                    goTouch = false
                    print("r")
                }
                if coordinatesTouch.x <= city2CoorX + ringSize && coordinatesTouch.x >= city2CoorX - ringSize &&
                    coordinatesTouch.y <= city2CoorY + ringSize && coordinatesTouch.y >= city2CoorY - ringSize {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesWrong2"), object: nil)
                    goTouch = false
                    print("w")
                }
                if coordinatesTouch.x <= city3CoorX + ringSize && coordinatesTouch.x >= city3CoorX - ringSize &&
                    coordinatesTouch.y <= city3CoorY + ringSize && coordinatesTouch.y >= city3CoorY - ringSize {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesWrong3"), object: nil)
                    goTouch = false
                    print("w2")
                }
            }
        }
    }
}

