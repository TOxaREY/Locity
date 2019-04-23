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
    func pulsate1Count() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}
////


class ViewControllerChoice: UIViewController {
    
    var dictionaryCountries:Dictionary<Int,String> = [:]
    var isoLabelEnable = true
    var i = 0
    var rand = 0
    let fontSize:CGFloat = 60
    let fontSize2:CGFloat = 40
    let fontSize3:CGFloat = 100

    @IBOutlet weak var wheelView: Wheel!
    @IBOutlet weak var flapBottomView: FlapBottom!
    @IBOutlet weak var labelRound: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var isoViewRemover: IsoViewRemover!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultContinentLabel: UILabel!
    @IBOutlet weak var resultCountryLabel: UILabel!
    @IBOutlet weak var anchorView: Anchor!
    @IBOutlet weak var isoView: UIView!
    @IBOutlet weak var isoViewFrame: UIImageView!
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var isoHead: UIImageView!
    @IBOutlet weak var flapTopView: FlapTop!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBAction func topButton(_ sender: Any) {
        diff = "H"
        topButton.isSelected = true
        if bottomButton.isSelected == false {
            bottomButton.isEnabled = false
            bottomButton.isHidden = true
            topButton.isEnabled = false
            topButton.isHidden = true
            topLabel.pulsate1Count()
            bottomLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.topLabel.isHidden = true
                self.addStartElement()
                print("H")
           }
        }
    }
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBAction func bottomButton(_ sender: Any) {
        diff = "E"
        bottomButton.isSelected = true
        if topButton.isSelected == false {
            topButton.isEnabled = false
            topButton.isHidden = true
            bottomButton.isEnabled = false
            bottomButton.isHidden = true
            bottomLabel.pulsate1Count()
            topLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.bottomLabel.isHidden = true
                self.addStartElement()
                print("E")
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
    func addStartElement(){
        print("addStartElement")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlap"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downFlap"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addAnchor"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addIsoFrameRemover"), object: nil)
        self.isoViewFrame.isHidden = false
        self.anchorView.isHidden = false
        self.isoLabel.isHidden = false
        self.isoLabel.textColor = .red
        self.isoLabel.text = "GO"
        self.flapTopLabel()
        self.blurView.isHidden = false
        self.labelRound.isHidden = false
        self.labelRound.frame.size = self.labelRound.intrinsicContentSize
        let effectView = UIVisualEffectView()
        effectView.frame = self.blurView.bounds
        effectView.effect = UIBlurEffect(style: .regular)
        self.blurView.addSubview(effectView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1, animations: {
                effectView.effect = nil
                self.labelRound.alpha = 0
            })
        }
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
        isoViewRemover.isHidden = true
        blurView.isHidden = true
        labelRound.isHidden = true
    }
    @objc func resultContinent() {
        do {
            for continent in try base.database.prepare(base.continentsTable.select(base.continent).filter(base.id == UserDefaults.standard.integer(forKey: "resultContinent"))) {
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
        
        checkSize(fS: self.fontSize2.dfz2)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "resultContinent"), object: nil)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeWheel"), object: nil)
                }
            }
        }
        
        checkSize(fS: self.fontSize2.dfz2 * 0.8)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "resultCountry"), object: nil)
    }
    @objc func enableButtonFlap(){
        topButton.isEnabled = true
        bottomButton.isEnabled = true
        topButton.isHidden = false
        bottomButton.isHidden = false
        topLabel.isHidden = false
        bottomLabel.isHidden = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableButtonFlap"), object: nil)
    }

    func flapTopLabel(){
        if self.isoLabelEnable {
            UIView.transition(with: self.isoLabel, duration: 1.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.flapTopLabel()
            }
        }
    }

    @objc func enableSpinButton(){
        spinButton.isEnabled = true
        spinButton.isHidden = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
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
            for country in try base.database.prepare(base.countriesTable.select(base.iso).filter(base.id_continent == UserDefaults.standard.integer(forKey: "resultContinent"))) {
                dictionaryCountries[c] = country[base.iso]
                c += 1
            }
        } catch {
            print(error)
        }
        selectCountries(dic: dictionaryCountries)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectCountry"), object: nil)
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
                    do {
                        for idSelect in try base.database.prepare(base.countriesTable.select(base.id, base.country).where(base.iso == self.dictionaryCountries[random]!)){
                            print("id: \(idSelect[base.id]), \(language): \(idSelect[base.country])")
                            UserDefaults.standard.set(idSelect[base.country], forKey: "resultCountry")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resultCountry"), object: nil)
                            idSelectCountry = idSelect[base.id]
                            print(idSelectCountry)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    @objc func breakdown2(){
        UIView.animate(withDuration: 3.75, animations: {
            self.resultContinentLabel.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width / 2 + self.resultContinentLabel.frame.width / 2), y: 0)
        }, completion: { done in
            self.resultContinentLabel.isHidden = true
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sB.instantiateViewController(withIdentifier: "VCM")
            appDel.window?.rootViewController = newVC
            appDel.window?.makeKeyAndVisible()
            })
        UIView.animate(withDuration: 3.75, animations: {
            self.resultCountryLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 + self.resultCountryLabel.frame.width / 2, y: 0)
        }, completion: { done in
            self.resultCountryLabel.isHidden = true
       })
        self.isoLabel.isHidden = true
        self.isoViewRemover.isHidden = false
        self.isoViewFrame.isHidden = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "breakdown2"), object: nil)
    }
    
    @objc func enableAddStartElement(){
        print("enableAddStart")
        addStartElement()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enableAddStartElement"), object: nil)
    }
    func deinitFalse(){
        deinitSKVWheelVCC = false
        deinitSKVFTVCC = false
        deinitSKVFBVCC = false
        deinitSKVAnchorVCC = false
        deinitSKVIsoViewRemoverVCC = false
        deinitVCC = false
    }
    deinit {
        print("deinitVCC")
        deinitVCC = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deinitFalse()
        disableButtonLabelStart()
        labelRound.text = "\(round)/5"

////Dispatch for loading orientation device
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.topLabel.font = self.topLabel.font.withSize(self.fontSize.dfz)
            self.bottomLabel.font = self.bottomLabel.font.withSize(self.fontSize.dfz)
            self.labelRound.font = self.labelRound.font.withSize(self.fontSize3.dfz)
            self.isoLabel.font = self.isoLabel.font.withSize(self.fontSize2.dfz2)
            isoViewHeight = self.isoView.frame.height
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableButtonFlap), name: NSNotification.Name(rawValue: "enableButtonFlap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableSpinButton), name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.resultContinent), name: NSNotification.Name(rawValue: "resultContinent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.resultCountry), name: NSNotification.Name(rawValue: "resultCountry"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectCountry), name: NSNotification.Name(rawValue: "selectCountry"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.breakdown2), name: NSNotification.Name(rawValue: "breakdown2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableAddStartElement), name: NSNotification.Name(rawValue: "enableAddStartElement"), object: nil)
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
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
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}

