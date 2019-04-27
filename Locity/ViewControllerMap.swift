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

var cityX = CGFloat()
var cityY = CGFloat()
var city2X = CGFloat()
var city2Y = CGFloat()
var city3X = CGFloat()
var city3Y = CGFloat()
var cityCoorX = CGFloat()
var cityCoorY = CGFloat()
var city2CoorX = CGFloat()
var city2CoorY = CGFloat()
var city3CoorX = CGFloat()
var city3CoorY = CGFloat()
var ringSize = CGFloat()
var resultTouchWrong = Bool()
var radiusToch = CGFloat()


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
    var clearCoordinates = CGPoint.zero
    var goTouch = Bool()
    var buttonNextRound = Bool()
    var enableButton = Bool()
    var transCompleteTrue = Bool()
    
    @IBOutlet weak var pointsTouchLabel: UILabel!
    @IBOutlet weak var mapViewTouch: Map!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var topFlapLabel: UILabel!
    @IBOutlet weak var bottomFlapLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var topSupport: UILabel!
    @IBOutlet weak var bottomSupport: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsLabelSupport: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var roundCityLabel: UILabel!
    @IBAction func homeButton(_ sender: Any) {
        print("push")
        if buttonNextRound && round == 5 {
            print("list")
            } else {
            if buttonNextRound {
                round += 1
                print("next")
                print(points)
                let appDel = UIApplication.shared.delegate as! AppDelegate
                let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = sB.instantiateViewController(withIdentifier: "VCC")
                appDel.window?.rootViewController = newVC
                appDel.window?.makeKeyAndVisible()
            } else {
                diff = ""
                round = 1
                points = "0"
                let appDel = UIApplication.shared.delegate as! AppDelegate
                let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = sB.instantiateViewController(withIdentifier: "VCS")
                appDel.window?.rootViewController = newVC
                appDel.window?.makeKeyAndVisible()
            }
        }
    }
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeImageSupport: UILabel!
    
    
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
    func effectMovePointsLabel(text:String,x:CGFloat,y:CGFloat){
        let coordinateTouchX = x
        let coordinateTouchY = blurView.frame.height - (y + roundLabel.frame.height)
        if coordinateTouchX <= mapViewTouch.frame.width / 2 {
            pointsTouchLabel.center.x = coordinateTouchX + ringSize * 1.2
            pointsTouchLabel.center.y = coordinateTouchY - ringSize * 1.2
        } else {
            pointsTouchLabel.center.x = coordinateTouchX - ringSize * 1.2
            pointsTouchLabel.center.y = coordinateTouchY - ringSize * 1.2
        }
        pointsTouchLabel.text = text
        pointsTouchLabel.isHidden = false
        pointsTouchLabel.backgroundColor = .clear
        var bounds = pointsTouchLabel.bounds
        bounds.size = pointsTouchLabel.intrinsicContentSize
        pointsTouchLabel.bounds = bounds
        pointsTouchLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1, animations: {
            self.pointsTouchLabel.transform = .identity
        }, completion: { done in
        var finalCenter = CGPoint.zero
            finalCenter.x = self.pointsLabel.center.x
            finalCenter.y = self.pointsLabel.center.y
            let containerCenter = self.pointsTouchLabel.center
        let deltaX = finalCenter.x - containerCenter.x
        let deltaY = finalCenter.y - containerCenter.y
            let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translation = CGAffineTransform(translationX: deltaX, y: deltaY)
        UIView.animate(withDuration: 2, animations: {
            self.pointsTouchLabel.transform = scale.concatenating(translation)
        }, completion: { done in
            self.pointsLabelSupport.isHidden = false
            self.pointsLabel.text = String(Int(self.pointsTouchLabel.text!)! + Int(self.pointsLabel.text!)!)
            self.pointsTouchLabel.isHidden = true
            self.pointsTouchLabel.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.transition(with: self.pointsLabel, duration: 2.0, options: .transitionFlipFromLeft, animations: nil, completion: { done in
                    if self.roundCity != 3 {
                            self.roundCity += 1
                            self.startVCM()
                            self.startLabelVCM()
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetCitys"), object: nil)
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetCitys"), object: nil)
                        self.homeImage.image = UIImage(named: "arrowFinal.png")
                        self.buttonNextRound = true
                        self.homeImageSupport.isHidden = false
                        self.homeImage.pulsateForever()
                        points = self.pointsLabel.text!
                    }
            })
            }
          })
        })
    }

    @objc func transComplete(){
        transCompleteTrue = true
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
        if enableButton {
            homeButtonOutlet.isHidden = false
            homeButtonOutlet.isEnabled = true
            print("enableButtonComplete")
        }
        if diff == "E" {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addCitys"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coorCityHard"), object: nil)
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "transComplete"), object: nil)
    }
    
    func coordinate(cityName:String,cityNumder:String){
        switch  cityNumder {
        case "c1":
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    cityX = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            };
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == cityName)){
                    cityY = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
        case "c2":
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    city2X = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            };
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.y).filter(base.city == cityName)){
                    city2Y = CGFloat(city[base.y])
                }
            } catch {
                print(error)
            }
        case "c3":
            do {
                for city in try base.database.prepare(base.citiesTable.select(base.x).filter(base.city == cityName)){
                    city3X = CGFloat(city[base.x])
                }
            } catch {
                print(error)
            };
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
                    coordinate(cityName: city, cityNumder: "c1")
                } else {
                    if rand2 == 0 {
                        rand2 = random
                        city = dic[random]!
                        print("c: \(city)")
                        coordinate(cityName: city, cityNumder: "c1")
                    } else {
                        city = dic[random]!
                        rand3 = random
                        print("c: \(city)")
                        coordinate(cityName: city, cityNumder: "c1")
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
                coordinate(cityName: city, cityNumder: "c1")
                randomFuncCity(dic: dic)
            } else {
                if rand2 == 0 {
                    rand2 = random
                    city = dic[random]!
                    print("c: \(city)")
                    coordinate(cityName: city, cityNumder: "c1")
                    randomFuncCity(dic: dic)
                } else {
                    city = dic[random]!
                    rand3 = random
                    print("c: \(city)")
                    coordinate(cityName: city, cityNumder: "c1")
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
                coordinate(cityName: city2, cityNumder: "c2")
                randSupport = random
                randomFuncCity(dic: dic)
            } else {
                city3 = dic[random]!
                print("c3: \(city3)")
                coordinate(cityName: city3, cityNumder: "c3")
                randSupport = 0
            }
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
    @objc func enableVCM(){
        startLabelVCM()
////
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.deinitComplete), userInfo: nil, repeats: true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableVCM"), object: nil)
    }
////
    @objc func deinitComplete(){
        if deinitSKVWheelVCC && deinitSKVFTVCC && deinitSKVFBVCC && deinitSKVAnchorVCC && deinitSKVIsoViewRemoverVCC && deinitVCC && deinitVCS && transCompleteTrue {
            timer.invalidate()
            homeButtonOutlet.isHidden = false
            homeButtonOutlet.isEnabled = true
            enableButton = true
            print("enableButton")
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deinitComplete"), object: nil)
            
        }
    }
    func startVCM(){
        homeButtonOutlet.isHidden = true
        homeButtonOutlet.isEnabled = false
        transCompleteTrue = false
        homeImage.image = UIImage(named: "home.png")
        homeImage.isHidden = true
        topSupport.isHidden = true
        bottomSupport.isHidden = true
        bottomFlapLabel.isHidden = true
        buttonNextRound = false
        topFlapLabel.isHidden = true
        countryLabel.isHidden = true
        cityLabel.isHidden = true
        roundLabel.isHidden = true
        roundCityLabel.isHidden = true
        pointsLabel.isHidden = true
        pointsLabelSupport.isHidden = true
        homeImageSupport.isHidden = true
        pointsTouchLabel.font = self.pointsTouchLabel.font.withSize(self.fontSize3.dfz2 * 2)
        pointsLabel.font = self.pointsLabel.font.withSize(self.fontSize3.dfz2)
        roundLabel.font = self.roundLabel.font.withSize(self.fontSize2.dfz2)
        roundCityLabel.font = self.roundCityLabel.font.withSize(self.fontSize2.dfz2)
        goTouch = false
        pointsTouchLabel.isHidden = true
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
        //
//        round = 5
        idSelectCountry = 20
//        diff = "H"
        //
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
        
        pointsLabel.text = points
        startVCM()
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableVCM), name: NSNotification.Name(rawValue: "enableVCM"), object: nil)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            if diff == "E" {
            if goTouch {
                coordinatesTouch = touch.location(in: mapViewTouch)
                coordinatesTouch.y = mapViewTouch.frame.height - self.coordinatesTouch.y
                if pow(CGFloat(abs(coordinatesTouch.x - cityCoorX)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.y - cityCoorY)),2) && pow(CGFloat(abs(coordinatesTouch.y - cityCoorY)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.x - cityCoorX)),2) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesRight"), object: nil)
                    goTouch = false
                    effectMovePointsLabel(text: "10",x: cityCoorX, y: cityCoorY)
                } else {
                    if pow(CGFloat(abs(coordinatesTouch.x - city2CoorX)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.y - city2CoorY)),2) && pow(CGFloat(abs(coordinatesTouch.y - city2CoorY)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.x - city2CoorX)),2) {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesWrong2"), object: nil)
                        goTouch = false
                        effectMovePointsLabel(text: "0",x: city2CoorX, y: city2CoorY)
                    } else {
                        if pow(CGFloat(abs(coordinatesTouch.x - city3CoorX)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.y - city3CoorY)),2) && pow(CGFloat(abs(coordinatesTouch.y - city3CoorY)),2) <= pow(CGFloat(ringSize),2) - pow(CGFloat(abs(coordinatesTouch.x - city3CoorX)),2) {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coordinatesWrong3"), object: nil)
                            goTouch = false
                            effectMovePointsLabel(text: "0",x: city3CoorX, y: city3CoorY)
                        }
                    }
                }
                }
            } else {
                if goTouch {
                    clearCoordinates = touch.location(in: blurView)
                    let halfFrameBlur = blurView.frame.height / 2
                    let halfFrameMap = mapImage.frame.height / 2
                    print(mapImage.image!.size)
                    coordinatesTouch = touch.location(in: mapViewTouch)
                    coordinatesTouch.y = mapViewTouch.frame.height - self.coordinatesTouch.y
                    radiusToch = CGFloat(sqrtf(Float((pow(CGFloat(abs(coordinatesTouch.x - cityCoorX)),2)) + pow(CGFloat(abs(coordinatesTouch.y - cityCoorY)),2))))
                    if clearCoordinates.y >= blurView.frame.height - halfFrameBlur - halfFrameMap && clearCoordinates.y <= halfFrameBlur + halfFrameMap {
                        if radiusToch >= 4 * ringSize {
                            resultTouchWrong = true
                            effectMovePointsLabel(text: "0", x: coordinatesTouch.x, y: coordinatesTouch.y)
                            } else {
                            resultTouchWrong = false
                            if radiusToch <= 0.75 * ringSize {
                                effectMovePointsLabel(text: "50", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                } else {
                                if radiusToch > 0.75 * ringSize && radiusToch <= 1.075 * ringSize {
                                    effectMovePointsLabel(text: "45", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                    } else {
                                    if radiusToch > 1.075 * ringSize && radiusToch <= 1.4 * ringSize {
                                        effectMovePointsLabel(text: "40", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                        } else {
                                        if radiusToch > 1.4 * ringSize && radiusToch <= 1.725 * ringSize {
                                            effectMovePointsLabel(text: "35", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                            } else {
                                            if radiusToch > 1.725 * ringSize && radiusToch <= 2.05 * ringSize {
                                                effectMovePointsLabel(text: "30", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                } else {
                                                if radiusToch > 2.05 * ringSize && radiusToch <= 2.375 * ringSize {
                                                    effectMovePointsLabel(text: "25", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                    } else {
                                                    if radiusToch > 2.375 * ringSize && radiusToch <= 2.7 * ringSize {
                                                        effectMovePointsLabel(text: "20", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                        } else {
                                                        if radiusToch > 2.7 * ringSize && radiusToch <= 3.025 * ringSize {
                                                            effectMovePointsLabel(text: "15", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                            } else {
                                                            if radiusToch > 3.025 * ringSize && radiusToch <= 3.35 * ringSize {
                                                                effectMovePointsLabel(text: "10", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                                } else {
                                                                if radiusToch > 3.35 * ringSize && radiusToch <= 3.675 * ringSize {
                                                                    effectMovePointsLabel(text: "5", x: coordinatesTouch.x, y: coordinatesTouch.y)
                                                                    } else {
                                                                    if radiusToch > 3.675 * ringSize && radiusToch < 4.0 * ringSize {
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawAndScaleCircle"), object: nil)
                        goTouch = false
                 }
            }
        }
   }
}
}




