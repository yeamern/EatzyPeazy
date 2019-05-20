//
//  Expiry+CoreDataProperties.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 20/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Expiry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expiry> {
        return NSFetchRequest<Expiry>(entityName: "Expiry")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?

}
