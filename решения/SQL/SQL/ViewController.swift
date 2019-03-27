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



class ViewController: UIViewController {

    var database: Connection!

    let contiTable = Table("contins")
    let id = Expression<Int>("id")
    let contin = Expression<String>("contin")

    
    override func viewDidLoad() {
        super.viewDidLoad()
                do {
                    let dbPath = Bundle.main.path(forResource: "world", ofType: "db")!
                    let database = try Connection(dbPath, readonly: true)
                    self.database = database
        
                } catch {
                    print(error)
                }
//        do {
//            let cont = try self.database.prepare(self.contiTable)
//            for con in cont {
//                print(con[self.contin])

                print(contiTable.filter(id == 3))
//            }
//        } catch {
//            print(error)
//        }
        
        

    }
}

