//
//  Categoria+CoreDataProperties.swift
//  PerretesFashion
//
//  Created by DAM2T1 on 5/3/18.
//  Copyright © 2018 DAM2T1. All rights reserved.
//
//

import Foundation
import CoreData


extension Categoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categoria> {
        return NSFetchRequest<Categoria>(entityName: "Categoria")
    }

    @NSManaged public var tipoVestimenta: String?
    @NSManaged public var categoriaPerrete: NSSet?

}

// MARK: Generated accessors for categoriaPerrete
extension Categoria {

    @objc(addCategoriaPerreteObject:)
    @NSManaged public func addToCategoriaPerrete(_ value: PerreteFashion)

    @objc(removeCategoriaPerreteObject:)
    @NSManaged public func removeFromCategoriaPerrete(_ value: PerreteFashion)

    @objc(addCategoriaPerrete:)
    @NSManaged public func addToCategoriaPerrete(_ values: NSSet)

    @objc(removeCategoriaPerrete:)
    @NSManaged public func removeFromCategoriaPerrete(_ values: NSSet)

}
