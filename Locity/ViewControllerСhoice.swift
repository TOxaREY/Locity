//
//  ViewControllerСhoice.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SpriteKit
import SQLite

////Check height
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
////

////Dynamic font size
extension CGFloat {
    var dfz: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}
extension CGFloat {
    var dfz2: CGFloat {
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
////
////Pulsate label
extension UILabel {
    func pulsate2Count() {
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
////

class ViewControllerChoice: UIViewController {
    
    let base = Base()
    var dictionaryCountries:Dictionary<Int,String> = [:]
    var isoLabelEnable = true
    var i = 0
    var rand = 0
    
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultContinentLabel: UILabel!
    @IBOutlet weak var resultCountryLabel: UILabel!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var isoView: UIView!
    @IBOutlet weak var isoViewFrame: UIImageView!
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var isoHead: UIImageView!
    @IBOutlet weak var flapTopView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBAction func topButton(_ sender: Any) {
        topButton.isSelected = true
        if bottomButton.isSelected == false {
            bottomButton.isEnabled = false
            bottomButton.isHidden = true
            topButton.isEnabled = false
            topButton.isHidden = true
            topLabel.pulsate2Count()
            bottomLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlap"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
                self.isoViewFrame.isHidden = false
                self.anchorView.isHidden = false
                self.topLabel.isHidden = true
           }
        }
    }
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBAction func bottomButton(_ sender: Any) {
        bottomButton.isSelected = true
        if topButton.isSelected == false {
            topButton.isEnabled = false
            topButton.isHidden = true
            bottomButton.isEnabled = false
            bottomButton.isHidden = true
            bottomLabel.pulsate2Count()
            topLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlap"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
                self.isoViewFrame.isHidden = false
                self.anchorView.isHidden = false
                self.bottomLabel.isHidden = true
            }
        }
    }
    @IBOutlet weak var spinButton: UIButton!
    @IBAction func spinButton(_ sender: Any) {
        spinButton.isEnabled = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spinWheel"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downAnchor"), object: nil)
        isoLabelEnable = false
        isoLabel.isHidden = true
        isoHead.isHidden = false
    }
    func disableButtonLabelStart(){
        topButton.isEnabled = false
        bottomButton.isEnabled = false
        topButton.isHidden = true
        bottomButton.isHidden = true
        spinButton.isEnabled = false
        spinButton.isHidden = true
        isoViewFrame.isHidden = true
        anchorView.isHidden = true
        topLabel.isHidden = true
        bottomLabel.isHidden = true
        isoLabel.isHidden = true
        isoHead.isHidden = true
        resultCountryLabel.isHidden = true
        resultContinentLabel.isHidden = true
    }
    @objc func resultContinent() {
        do {
            for continent in try self.base.database.prepare(self.base.continentsTable.select(base.continent).filter(base.id == UserDefaults.standard.integer(forKey: "resultContinent"))) {
                resultContinentLabel.text = continent[base.continent].uppercased()
            }
        } catch {
            print(error)
        }
        resultContinentLabel.isHidden = false
        resultContinentLabel.backgroundColor = .white
        resultContinentLabel.layer.borderColor = UIColor.black.cgColor
        resultContinentLabel.layer.borderWidth = 2.0
        var bounds = resultContinentLabel.bounds
    
        func checkSize(fS:CGFloat) {
            var fS = fS
            resultContinentLabel.font = resultContinentLabel.font.withSize(CGFloat(fS))
            bounds.size = resultContinentLabel.intrinsicContentSize
            bounds.size.width = bounds.size.width + 20
            bounds.size.height = bounds.size.height + 5
            if bounds.size.width > resultContinentLabel.frame.width {
                fS -= 1
                checkSize(fS: fS)
            } else {
                resultContinentLabel.bounds = bounds
                resultContinentLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                UIView.animate(withDuration: 2.0) {
                    self.resultContinentLabel.transform = .identity
                }
            }
        }
        
        checkSize(fS: 50)
    }
    @objc func resultCountry() {
        resultCountryLabel.isHidden = false
        resultCountryLabel.backgroundColor = .white
        resultCountryLabel.text = UserDefaults.standard.string(forKey: "resultCountry")?.uppercased()
        resultCountryLabel.layer.borderColor = UIColor.black.cgColor
        resultCountryLabel.layer.borderWidth = 2.0
        var bounds = resultCountryLabel.bounds
        
        func checkSize(fS:CGFloat) {
            var fS = fS
            resultCountryLabel.font = resultCountryLabel.font.withSize(CGFloat(fS))
            bounds.size = resultCountryLabel.intrinsicContentSize
            bounds.size.width = bounds.size.width + 20
            bounds.size.height = bounds.size.height + 5
            if bounds.size.width > resultCountryLabel.frame.width {
                fS -= 1
                checkSize(fS: fS)
            } else {
                resultCountryLabel.bounds = bounds
                resultCountryLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                UIView.animate(withDuration: 2.0) {
                    self.resultCountryLabel.transform = .identity
                }
            }
        }
        
        checkSize(fS: 40)
    }
    @objc func enableButton(){
        topButton.isEnabled = true
        bottomButton.isEnabled = true
        topButton.isHidden = false
        bottomButton.isHidden = false
        topLabel.isHidden = false
        bottomLabel.isHidden = false
    }

    func flapTopLabel(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isoLabelEnable {
            UIView.transition(with: self.isoLabel, duration: 1.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
            self.flapTopLabel()
            }
        }
    }

    @objc func enableSpinButton(){
        spinButton.isEnabled = true
        spinButton.isHidden = false
        isoViewFrame.isHidden = false
        isoLabel.isHidden = false
        isoLabel.textColor = .red
        isoLabel.text = "GO"
        flapTopLabel()

    }
    @objc func selectCountry(){
        isoHead.isHidden = true
        isoLabel.text = ""
        isoLabel.textColor = .black
        isoLabel.isHidden = false
        i = 0
        rand = 0
        do {
            var c = 1
            for country in try self.base.database.prepare(self.base.countriesTable.select(base.iso).filter(base.id_continent == UserDefaults.standard.integer(forKey: "resultContinent"))) {
                dictionaryCountries[c] = country[base.iso]
                c += 1
            }
            print(dictionaryCountries)
        } catch {
            print(error)
        }
        selectCountries(dic: dictionaryCountries)
    }
    func selectCountries(dic:Dictionary<Int, String>) {
        let random = Int.random(in: 1...dic.count)
////Check two equal in a row
        if rand == random {
////
            selectCountries(dic: dic)
        } else {
            rand = random
////Speed view loop countries
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
////
                self.isoLabel.text = self.dictionaryCountries[random]
                self.i += 1
                if self.i != 20 {
                    self.selectCountries(dic: dic)
                } else {
                    var idSelectCountry = Int()
//                    var cityDicRandom = [Int]()
//                    var citySelect:Dictionary<String,Any> = [:]
                    do {
                        for idSelect in try self.base.database.prepare(self.base.countriesTable.select(self.base.id, self.base.country).where(self.base.iso == self.dictionaryCountries[random]!)){
                            print("id: \(idSelect[self.base.id]), en: \(idSelect[self.base.country])")
                            UserDefaults.standard.set(idSelect[self.base.country], forKey: "resultCountry")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resultCountry"), object: nil)
                            idSelectCountry = idSelect[self.base.id]
                        }
                    } catch {
                        print(error)
                    }
//                    do {
//                        for number in try self.base.database.prepare(self.base.citysTable.select(self.base.id).filter(self.base.id_country == id_country)){
//                            cityDicRandom.append(number[self.base.id])
//                        }
//                    } catch {
//                        print(error)
//                    }
//                    do {
//                        for item in try self.base.database.prepare(self.base.citysTable.select(self.base.city, self.base.ru, self.base.y).filter(self.base.id == cityDicRandom.randomIndexRemove()!)) {
//                            citySelect["en"] = item[self.base.city]
//                            citySelect["ru"] = item[self.base.ru]
//                            citySelect["y"] = item[self.base.y]
//                        }
//                        print(citySelect)
//                    } catch {
//                        print(error)
//                    }
//                    //Второй вызов взамен его должно быть сообщение об завершение первой попытки и вызов этой части
//                    do {
//                        for item in try self.base.database.prepare(self.base.citysTable.select(self.base.city, self.base.ru, self.base.y).filter(self.base.id == cityDicRandom.randomIndexRemove()!)) {
//                            citySelect["en"] = item[self.base.city]
//                            citySelect["ru"] = item[self.base.ru]
//                            citySelect["y"] = item[self.base.y]
//                        }
//                        print(citySelect)
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "up"), object: nil)
//                    } catch {
//                        print(error)
//                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(language)
        disableButtonLabelStart()
        let halfWheelSize = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") / 2)
        var proportWheelSize = CGFloat()
        switch screenHeight {
        case 896,812:
            proportWheelSize = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") * 0.08 + 7)
        default:
            proportWheelSize = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") * 0.08)
        }
        let proportWheelSize2 = CGFloat(proportWheelSize + (flapTopView.frame.height - halfWheelSize) / 2)
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        self.resultView.bottomAnchor.constraint(equalTo: self.resultView.superview!.bottomAnchor, constant: -halfWheelSize).isActive = true
        self.anchorView.translatesAutoresizingMaskIntoConstraints = false
        self.anchorView.bottomAnchor.constraint(equalTo: self.anchorView.superview!.bottomAnchor, constant: proportWheelSize).isActive = true
        self.anchorView.heightAnchor.constraint(equalToConstant: proportWheelSize2).isActive = true
        self.isoView.translatesAutoresizingMaskIntoConstraints = false
        self.isoView.topAnchor.constraint(equalTo: self.isoView.superview!.topAnchor, constant: halfWheelSize).isActive = true
        switch screenHeight {
        case 896,812:
            self.spinButton.topAnchor.constraint(equalTo: self.spinButton.superview!.topAnchor, constant: halfWheelSize * 1.3).isActive = true
        default:
            self.spinButton.topAnchor.constraint(equalTo: self.spinButton.superview!.topAnchor, constant: halfWheelSize * 1.23).isActive = true
        }
////Dispatch for loading orientation device
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let fontSize:CGFloat = 60
            let fontSize2:CGFloat = 40
            self.topLabel.font = self.topLabel.font.withSize(fontSize.dfz)
            self.bottomLabel.font = self.bottomLabel.font.withSize(fontSize.dfz)
            self.isoLabel.font = self.isoLabel.font.withSize(fontSize2.dfz2)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableButton), name: NSNotification.Name(rawValue: "restingDown"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableSpinButton), name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.resultContinent), name: NSNotification.Name(rawValue: "resultContinent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.resultCountry), name: NSNotification.Name(rawValue: "resultCountry"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectCountry), name: NSNotification.Name(rawValue: "upAnchor"), object: nil)
        

        
        
        
        
    }
}
