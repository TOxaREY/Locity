//
//  City.swift
//  weq
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    @objc dynamic var name = ""
    @objc dynamic var ru = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var country: Country!
}
