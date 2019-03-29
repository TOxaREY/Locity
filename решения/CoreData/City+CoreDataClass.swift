//
//  City+CoreDataClass.swift
//  letter&data
//
//  Created by REYNIKOV ANTON on 21/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "City"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }

}
