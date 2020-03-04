//
//  Languages+CoreDataProperties.swift
//  DemoMovies
//
//  Created by Vijay A on 04/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension Languages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Languages> {
        return NSFetchRequest<Languages>(entityName: "Languages")
    }

    @NSManaged public var iso_639_1: String?
    @NSManaged public var name: String?

}
