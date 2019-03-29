//
//  Country+CoreDataProperties.swift
//  letter&data
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var en: String?
    @NSManaged public var iso: String?
    @NSManaged public var ru: String?
    @NSManaged public var citys: NSSet?

}

// MARK: Generated accessors for citys
extension Country {

    @objc(addCitysObject:)
    @NSManaged public func addToCitys(_ value: City)

    @objc(removeCitysObject:)
    @NSManaged public func removeFromCitys(_ value: City)

    @objc(addCitys:)
    @NSManaged public func addToCitys(_ values: NSSet)

    @objc(removeCitys:)
    @NSManaged public func removeFromCitys(_ values: NSSet)

}
