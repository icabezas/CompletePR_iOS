//
//  User+CoreDataProperties.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 5/3/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var userPerrete: NSSet?

}

// MARK: Generated accessors for userPerrete
extension User {

    @objc(addUserPerreteObject:)
    @NSManaged public func addToUserPerrete(_ value: PerreteFashion)

    @objc(removeUserPerreteObject:)
    @NSManaged public func removeFromUserPerrete(_ value: PerreteFashion)

    @objc(addUserPerrete:)
    @NSManaged public func addToUserPerrete(_ values: NSSet)

    @objc(removeUserPerrete:)
    @NSManaged public func removeFromUserPerrete(_ values: NSSet)

}
