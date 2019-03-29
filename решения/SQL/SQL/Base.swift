//
//  Base.swift
//  SQL
//
//  Created by REYNIKOV ANTON on 28/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SQLite


class Base {
    var database: Connection!
    
    let countrysTable = Table("countrys")
    let id_contin = Expression<Int>("id_contin")
    let iso = Expression<String>("iso")
    let contTable = Table("contins")
    let id = Expression<Int>("id")
    let contin = Expression<String>("contin")
    let country = Expression<String>("country")
    let citysTable = Table("citys")
    let city = Expression<String>("city")
    let ru = Expression<String>("ru")
    let y = Expression<Double>("y")
    let id_country = Expression<Int>("id_country")
    
    
    
    init() {
        do {
    let dbPath = Bundle.main.path(forResource: "world", ofType: "db")!
    let database = try Connection(dbPath, readonly: true)
    self.database = database
    print("Connect")
    } catch {
    print(error)
    }
  }
}
