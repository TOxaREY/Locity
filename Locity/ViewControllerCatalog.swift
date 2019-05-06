//
//  ViewControllerCatalog.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 30/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SQLite


class ViewControllerCatalog: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var arrayCoutries:Array<String> = []
    var pickerCountry = String()
    var pushButton = Bool()
    var rand = 0
    var arrayMosaic = [UIImageView]()
    var arrayMosaicTemp = [UIImageView]()
    
    @IBOutlet weak var mosaic1: UIImageView!
    @IBOutlet weak var mosaic2: UIImageView!
    @IBOutlet weak var mosaic3: UIImageView!
    @IBOutlet weak var mosaic4: UIImageView!
    @IBOutlet weak var mosaic5: UIImageView!
    @IBOutlet weak var mosaic6: UIImageView!
    @IBOutlet weak var mosaic7: UIImageView!
    @IBOutlet weak var mosaic8: UIImageView!
    @IBOutlet weak var mosaic9: UIImageView!
    @IBOutlet weak var buttonReturn: UIButton!
    @IBOutlet weak var okImage: UIImageView!
    @IBOutlet weak var mapView: MapCatalogView!
    @IBAction func buttonReturn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetMapAndCities"), object: nil)
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCS")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
    @IBAction func buttonOk(_ sender: Any) {
        okImage.image = UIImage(named: "okBlack.png")
        buttonOk.isEnabled = false
        pushButton = true
        do {
            for idCon in try base.database.prepare(base.countriesTable.select(base.id).filter(base.country == pickerCountry)) {
                idSelectCountry = idCon[base.id]
            }
        } catch {
            print(error)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMapAndCities"), object: nil)
        mapView.isHidden = false
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
        }
        pickerView.backgroundColor = UIColor.white
        pickerLabel?.text = arrayCoutries[row]

        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let actualRow = self.picker.selectedRow(inComponent: 0)
        pickerCountry = arrayCoutries[actualRow]
        if pushButton {
            buttonOk.isEnabled = true
            mapView.isHidden = true
            okImage.image = UIImage(named: "okGrey.png")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetMapAndCities"), object: nil)
        }
        pushButton = false
        
    }
    
    func animationMosaic(name: UIImageView) {
        name.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        name.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            name.transform = .identity
        }, completion: { done in
            if self.arrayMosaicTemp.count != 0 {
                self.rand = Int.random(in: 0...self.arrayMosaicTemp.count - 1)
                self.animationMosaic(name: self.arrayMosaicTemp.remove(at: self.rand))
            } else {
                self.arrayMosaicTemp = self.arrayMosaic
                self.rand = Int.random(in: 0...self.arrayMosaicTemp.count - 1)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "animationMosaicReturn"), object: nil)
            }
        })
    }
    @objc func animationMosaicNotif(){
        animationMosaic(name: arrayMosaicTemp.remove(at: rand))
    }
    func animationMosaicReturn(name: UIImageView) {
        UIView.animate(withDuration: 0.5, animations: {
            name.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { done in
            name.isHidden = true
            if self.arrayMosaicTemp.count != 0 {
                self.rand = Int.random(in: 0...self.arrayMosaicTemp.count - 1)
                self.animationMosaicReturn(name: self.arrayMosaicTemp.remove(at: self.rand))
            } else {
                self.arrayMosaicTemp = self.arrayMosaic
                self.rand = Int.random(in: 0...self.arrayMosaicTemp.count - 1)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "animationMosaic"), object: nil)
            }
        })
    }
    @objc func animationMosaicReturnNotif(){
        animationMosaicReturn(name: arrayMosaicTemp.remove(at: rand))
    }
    
    
    
    deinit {
        print("deinitVCCat")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mosaic1.isHidden = true
        mosaic2.isHidden = true
        mosaic3.isHidden = true
        mosaic4.isHidden = true
        mosaic5.isHidden = true
        mosaic6.isHidden = true
        mosaic7.isHidden = true
        mosaic8.isHidden = true
        mosaic9.isHidden = true
        mapView.isHidden = true
        arrayMosaic = [mosaic1,mosaic2,mosaic3,mosaic4,mosaic5,mosaic6,mosaic7,mosaic8,mosaic9]
        arrayMosaicTemp = arrayMosaic
        rand = Int.random(in: 0...arrayMosaicTemp.count - 1)
        animationMosaic(name: arrayMosaicTemp.remove(at: rand))
        NotificationCenter.default.addObserver(self, selector: #selector(animationMosaicNotif), name: NSNotification.Name(rawValue: "animationMosaic"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animationMosaicReturnNotif), name: NSNotification.Name(rawValue: "animationMosaicReturn"), object: nil)
        
        okImage.image = UIImage(named: "okGrey.png")
        pushButton = false

        do {
            for cntr in try base.database.prepare(base.countriesTable.select(base.country)) {
                arrayCoutries.append(cntr[base.country])
                arrayCoutries = arrayCoutries.sorted {$0 < $1}
            }
        } catch {
            print(error)
        }
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }

}
