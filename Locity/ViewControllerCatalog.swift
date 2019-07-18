//
//  ViewControllerCatalog.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 30/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SQLite

extension UIView  {
    func isScrolling () -> Bool {
        
        if let scrollView = self as? UIScrollView {
            if  (scrollView.isDragging || scrollView.isDecelerating) {
                return true
            }
        }
        
        for subview in self.subviews {
            if ( subview.isScrolling() ) {
                return true
            }
        }
        return false
    }
}

class ViewControllerCatalog: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
    var arrayCoutries:Array<String> = []
    var pickerCountry = String()
    var pushButton = Bool()
    var iso = String()
    let letters = ["A":"\u{1F1E6}","B":"\u{1F1E7}","C":"\u{1F1E8}","D":"\u{1F1E9}","E":"\u{1F1EA}","F":"\u{1F1EB}","G":"\u{1F1EC}","H":"\u{1F1ED}","I":"\u{1F1EE}","J":"\u{1F1EF}","K":"\u{1F1F0}","L":"\u{1F1F1}","M":"\u{1F1F2}","N":"\u{1F1F3}","O":"\u{1F1F4}","P":"\u{1F1F5}","Q":"\u{1F1F6}","R":"\u{1F1F7}","S":"\u{1F1F8}","T":"\u{1F1F9}","U":"\u{1F1FA}","V":"\u{1F1FB}","W":"\u{1F1FC}","X":"\u{1F1FD}","Y":"\u{1F1FE}","Z":"\u{1F1FF}"]
    var flagString = String()
    var i = 0
    var rusDir = String()
    var e = 0

    @IBOutlet weak var northImage: UIImageView!
    @IBOutlet weak var northLeftImage: UIImageView!
    @IBOutlet weak var isoFlag: UILabel!
    @IBOutlet weak var buttonReturn: UIButton!
    @IBOutlet weak var okImage: UIImageView!
    @IBOutlet weak var mapView: MapCatalogView!
    @IBAction func buttonReturn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetMapAndCities"), object: nil)
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCS")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
    @IBAction func buttonOk(_ sender: Any) {
        if picker.isScrolling() == false {
        okImage.image = UIImage(named: "okBlack.png")
        buttonOk.isEnabled = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil)
        mapView.isHidden = false
        swip()
        }
    }
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCoutries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayCoutries[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Georgia-Bold", size: 20.0)!
            pickerLabel?.textAlignment = .center
            pickerLabel?.adjustsFontSizeToFitWidth = true
        }
        pickerView.backgroundColor = UIColor.white
        pickerLabel?.text = arrayCoutries[row]
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        isoFlag.text = ""
        flagString = ""
        checkArrow(direct: arrowCat).isHidden = true
        let actualRow = self.picker.selectedRow(inComponent: 0)
        pickerCountry = arrayCoutries[actualRow]
        baseCountry()
        buttonOk.isEnabled = true
        mapView.isHidden = true
        okImage.image = UIImage(named: "okGrey.png")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetMapAndCities"), object: nil)
        i = 0
    }
    
    func checkArrow(direct:String) -> (UIImageView) {
        var ii = UIImageView()
        if direct == "U" {
            ii = northImage
        } else if direct == "L" {
            ii = northLeftImage
        }
        return ii
    }
    func baseCountry() {
        do {
            for i in try base.database.prepare(base.countriesTable.select(base.iso).filter(base.country == pickerCountry)) {
                iso = i[base.iso]
                flagString.append(letters[String(iso.first!)]! + letters[String(iso.last!)]!)
                isoFlag.text = flagString
                if iso == "RU" {
                    break
                }
            }
        } catch {
            print(error)
        }
        do {
                for idCon in try base.database.prepare(base.countriesTable.select(base.id).filter(base.country == pickerCountry)) {
                    idSelectCountry = idCon[base.id]
                    print(idSelectCountry)
                }
        } catch {
            print(error)
        }

    }
    func swip() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        mapView.addGestureRecognizer(rightSwipe)
        mapView.addGestureRecognizer(leftSwipe)
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if idSelectCountry == 189 || idSelectCountry == 130 {
                switch idSelectCountry {
                case 189:
                    switch sender.direction {
                    case .right, .left: NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                    mapView.isHidden = false
                    checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                    checkArrow(direct: arrowCat).isHidden = false
                    UIView.animate(withDuration: 0.5) {
                        self.checkArrow(direct: arrowCat).transform = .identity
                    }
                   idSelectCountry = 130
                    if sender.direction == .left {
                        rusDir = "left"
                    } else if sender.direction == .right {
                        rusDir = "right"
                        }
                    default: break
                    }
                case 130:
                    if rusDir == "left" {
                    northImage.isHidden = true
                    if i == 0 {
                    switch sender.direction {
                    case .left: NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                    mapView.isHidden = false
                    checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                    checkArrow(direct: arrowCat).isHidden = false
                    UIView.animate(withDuration: 0.5) {
                        self.checkArrow(direct: arrowCat).transform = .identity
                    }
                        i += 1
                    case .right: checkArrow(direct: arrowCat).isHidden = true; NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil); idSelectCountry = 189
                    default: break
                    }
                    } else if i == 1 {
                        idSelectCountry = 189
                        switch sender.direction {
                        case .left: checkArrow(direct: arrowCat).isHidden = true; NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil); i = 0
                        case .right: northLeftImage.isHidden = true
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                        mapView.isHidden = false
                        checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                        checkArrow(direct: arrowCat).isHidden = false
                        UIView.animate(withDuration: 0.5) {
                            self.checkArrow(direct: arrowCat).transform = .identity
                        }; idSelectCountry = 130; i = 0
                        default: break
                        }
                    }
                    } else if rusDir == "right" {
                        northImage.isHidden = true
                        if i == 0 {
                            switch sender.direction {
                            case .left: checkArrow(direct: arrowCat).isHidden = true; NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil); idSelectCountry = 189
                            case .right: NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                            mapView.isHidden = false
                            checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                            checkArrow(direct: arrowCat).isHidden = false
                            UIView.animate(withDuration: 0.5) {
                                self.checkArrow(direct: arrowCat).transform = .identity
                            }
                            i += 1
                            default: break
                            }
                        } else if i == 1 {
                            idSelectCountry = 189
                            switch sender.direction {
                            case .left: northLeftImage.isHidden = true
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                            mapView.isHidden = false
                            checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                            checkArrow(direct: arrowCat).isHidden = false
                            UIView.animate(withDuration: 0.5) {
                                self.checkArrow(direct: arrowCat).transform = .identity
                            }; idSelectCountry = 130; i = 0
                            case .right: checkArrow(direct: arrowCat).isHidden = true; NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil); i = 0
                            default: break
                            }
                        }
                    }
                default: break
                }
            } else if i == 0 {
                switch sender.direction {
                case .right, .left: NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
                mapView.isHidden = false
                checkArrow(direct: arrowCat).transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                checkArrow(direct: arrowCat).isHidden = false
                UIView.animate(withDuration: 0.5) {
                    self.checkArrow(direct: arrowCat).transform = .identity
                }
                i = 1
                default: break
                }
            } else if i == 1 {
                switch sender.direction {
                case .right, .left: checkArrow(direct: arrowCat).isHidden = true; NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addContin"), object: nil)
                i = 0
                default: break
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @objc func pickerPan(panRecognizer: UIPanGestureRecognizer) {
        if panRecognizer.state == .began {
            if e == 0 {
                isoFlag.text = "\u{1F30E}"
            } else if e == 1 {
                isoFlag.text = "\u{1F30D}"
            } else if e == 2 {
                isoFlag.text = "\u{1F30F}"
            }
            flagString = ""
            checkArrow(direct: arrowCat).isHidden = true
            buttonOk.isEnabled = true
            mapView.isHidden = true
            okImage.image = UIImage(named: "okGrey.png")
            if e == 2 {
                e = 0
            } else {
                e += 1
            }
        }
    }

    deinit {
        print("deinitVCCat")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pickerPan))
        pan.delegate = self
        picker.addGestureRecognizer(pan)
        
        okImage.image = UIImage(named: "okGrey.png")
        northImage.isHidden = true
        northLeftImage.isHidden = true

        do {
            for cntr in try base.database.prepare(base.countriesTable.select(base.country)) {
                if cntr[base.country] == "Russia" || cntr[base.country] == "Россия" || cntr[base.country] == "Russie" || cntr[base.country] == "Rusia" || cntr[base.country] == "Rússia" || cntr[base.country] == "Russland" {
                    continue
                } else {
                arrayCoutries.append(cntr[base.country])
                }
            }
            for rus in try base.database.prepare(base.countriesTable.select(base.country).filter(base.id == 130)) {
                arrayCoutries.append(rus[base.country])
            }
            arrayCoutries = arrayCoutries.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        } catch {
            print(error)
        }
        pickerCountry = arrayCoutries[0]
        baseCountry()
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
