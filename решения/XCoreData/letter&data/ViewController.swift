//
//  ViewController.swift
//  letter&data
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var labelUp: UILabel!
    
    
    var i = 0
    var rand = 0
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
        i = 0
        rand = 0
        printi(arr: array)
    }
    
    var array = [1:"aq",2:"df",3:"gh",4:"se",5:"jh",6:"sp",7:"ff",8:"lj",9:"sd",10:"ns",11:"mo",12:"ws",13:"pp"]
    
    func printi(arr:Dictionary<Int, String>){
        let random = Int.random(in: 1...13)
        if rand == random {
            printi(arr: arr)
        } else {
            rand = random
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.label.text = arr[random]!
                self.i += 1
                if self.i != 20 {
                    self.printi(arr: arr)
                }
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let country = Country()
//        country.en = "Australia"
//        country.ru = "Австралия"
//        country.iso = "AU"
//
//        let city1 = City()
//        city1.name = "Sydney"
//        city1.ru = "Сидней"
//        city1.coor = 45.56
//        country.addToCitys(city1)
//
//        let city2 = City()
//        city2.name = "Melbourne"
//        city2.ru = "Мельбурн"
//        city2.coor = 56.89
//        country.addToCitys(city2)
//
//        let city3 = City()
//        city3.name = "Perth"
//        city3.ru = "Перт"
//        city3.coor = 36.45
//        country.addToCitys(city3)
        
//                let country = Country()
//                country.en = "New Zealand"
//                country.ru = "Новая Зеландия"
//                country.iso = "NZ"
//        
//                let city1 = City()
//                city1.name = "Auckland"
//                city1.ru = "Окленд"
//                city1.coor = 87.55
//        country.addToCitys(city1)
//        
//                let city2 = City()
//                city2.name = "Wellington"
//                city2.ru = "Веллингтон"
//                city2.coor = 16.33
//        country.addToCitys(city2)
//
//                let city3 = City()
//                city3.name = "Christchurch"
//                city3.ru = "Крайстчерч"
//                city3.coor = 25.74
//        country.addToCitys(city3)

//        CoreDataManager.instance.saveContext()

//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
//        do {
//            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
//            for result in results as! [Country] {
//                print(result)
//            }
//
//        } catch {
//
//            print("Failed")
//        }

    }
    
    
}
