//
//  Favorito+CoreDataProperties.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 27/05/25.
//
//

import Foundation
import CoreData


extension Favorito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorito> {
        return NSFetchRequest<Favorito>(entityName: "Favorito")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var category: String?
    @NSManaged public var thumbURL: String?
    @NSManaged public var instructions: String?
    @NSManaged public var ingredients: NSArray?

}

extension Favorito : Identifiable {

}
