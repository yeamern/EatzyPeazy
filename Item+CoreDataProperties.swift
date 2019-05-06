//
//  Item+CoreDataProperties.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 06/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?

}
