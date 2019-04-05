//
//  ViewController.swift
//  weq
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    let realm = try! Realm()
    lazy var countrys: Results<City> = { self.realm.objects(City.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        try! realm.write() {
//            let newCity = City()
//            newCity.name = "Sydney"
//            newCity.ru = "Сидней"
//            newCity.latitude = 45.45
//            newCity.longitude = 67.21
//            realm.add(newCity)
//        }
        countrys = realm.objects(City.self)
        print(countrys)
        
        
        
        
    }
}
