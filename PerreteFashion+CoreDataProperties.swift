//
//  PerreteFashion+CoreDataProperties.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 12/5/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//
//

import Foundation
import CoreData


extension PerreteFashion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PerreteFashion> {
        return NSFetchRequest<PerreteFashion>(entityName: "PerreteFashion")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var nombre: String?
    @NSManaged public var popularidad: Double
    @NSManaged public var img: NSData?
    @NSManaged public var perreteCategoria: Categoria?
    @NSManaged public var perreteUser: User?

}
