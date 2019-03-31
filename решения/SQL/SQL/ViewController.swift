//
//  ViewController.swift
//  SQL
//
//  Created by REYNIKOV ANTON on 22/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import SQLite
import Foundation

extension Array {
    mutating func randomIndexRemove() -> Element? {
        if isEmpty { return nil }
        let index = Int.random(in: 0...self.count-1)
        return self.remove(at: index)
    }
}


class ViewController: UIViewController {

    
    let base = Base()
    var dic:Dictionary<Int,String> = [:]
    var i = 0
    var rand = 0
    
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "down"), object: nil)
        i = 0
        rand = 0
        printi(dictionary: dic)
    }
    
    func printi(dictionary:Dictionary<Int, String>){
        let random = Int.random(in: 1...dictionary.count)
        if rand == random {
            printi(dictionary: dictionary)
        } else {
            rand = random
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.label.text = dictionary[random]!
                self.i += 1
                if self.i != 20 {
                    self.printi(dictionary: dictionary)
                } else {
                    
                    
                    
                    var id_country = Int()
                    var cityDicRandom = [Int]()
                    var citySelect:Dictionary<String,Any> = [:]
                    do {
                        for number in try self.base.database.prepare(self.base.countrysTable.select(self.base.id, self.base.country).where(self.base.iso == dictionary[random]!)){
                            print("id: \(number[self.base.id]), en: \(number[self.base.country])")
                            id_country = number[self.base.id]
                        }
                    } catch {
                        print(error)
                    }
                    do {
                        for number in try self.base.database.prepare(self.base.citysTable.select(self.base.id).filter(self.base.id_country == id_country)){
                            cityDicRandom.append(number[self.base.id])
                        }
                    } catch {
                        print(error)
                    }
                    do {
                        for item in try self.base.database.prepare(self.base.citysTable.select(self.base.city, self.base.ru, self.base.y).filter(self.base.id == cityDicRandom.randomIndexRemove()!)) {
                            citySelect["en"] = item[self.base.city]
                            citySelect["ru"] = item[self.base.ru]
                            citySelect["y"] = item[self.base.y]
                        }
                        print(citySelect)
                    } catch {
                        print(error)
                    }
//Второй вызов взамен его должно быть сообщение об завершение первой попытки и вызов этой части
                    do {
                        for item in try self.base.database.prepare(self.base.citysTable.select(self.base.city, self.base.ru, self.base.y).filter(self.base.id == cityDicRandom.randomIndexRemove()!)) {
                            citySelect["en"] = item[self.base.city]
                            citySelect["ru"] = item[self.base.ru]
                            citySelect["y"] = item[self.base.y]
                        }
                        print(citySelect)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "up"), object: nil)
                    } catch {
                        print(error)
                    }
          }
        }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                do {
                    var y = 1
                    for counti in try self.base.database.prepare(self.base.countrysTable.select(base.iso).filter(base.id_contin == 4)) {
                        dic[y] = counti[base.iso]
                        y += 1
                   }
                        print(dic)

                } catch {
                    print(error)
                }

    }
}

