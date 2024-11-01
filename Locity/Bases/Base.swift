//
//  Base.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 09/04/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import SQLite

class Base {
    var database: Connection!
    
    
    
    let continentsTable = Table("Continents")
    let id = Expression<Int>("id")
    let continent = Expression<String>(language)
    let continCat = Expression<String>("en")
    
    let countriesTable = Table("Countries")
    let country = Expression<String>(language)
    let iso = Expression<String>("iso")
    let map = Expression<String>("map")
    let arrow = Expression<String>("arrow")
    let square = Expression<String>("square")
    let id_continent = Expression<Int>("id_continent")
    
    let citiesTable = Table("Cities")
    let city = Expression<String>(language)
    let x = Expression<Double>("x")
    let y = Expression<Double>("y")
    let capital = Expression<String>("capital")
    let dir = Expression<String>("dir")
    let id_country = Expression<Int>("id_country")
    
    init() {
        do {
            let dbPath = Bundle.main.path(forResource: "world", ofType: "db")!
            let database = try Connection(dbPath, readonly: true)
            self.database = database
            print("db_connect")
        } catch {
            print(error)
        }
    }
    deinit {
        print("deinitBase")
    }
}

