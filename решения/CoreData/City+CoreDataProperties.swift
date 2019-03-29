//
//  City+CoreDataProperties.swift
//  letter&data
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var coor: Double
    @NSManaged public var name: String?
    @NSManaged public var ru: String?
    @NSManaged public var countryy: Country?

}
