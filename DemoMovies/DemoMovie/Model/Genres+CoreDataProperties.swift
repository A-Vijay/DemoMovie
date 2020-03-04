//
//  Genres+CoreDataProperties.swift
//  DemoMovies
//
//  Created by Vijay A on 04/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension Genres {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genres> {
        return NSFetchRequest<Genres>(entityName: "Genres")
    }

    @NSManaged public var genreID: Int64
    @NSManaged public var name: String?

}
