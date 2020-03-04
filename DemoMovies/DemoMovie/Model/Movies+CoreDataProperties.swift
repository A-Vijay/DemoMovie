//
//  Movies+CoreDataProperties.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double

}
