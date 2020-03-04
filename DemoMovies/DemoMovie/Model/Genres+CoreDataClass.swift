//
//  Genres+CoreDataClass.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Genres)
public class Genres: NSManagedObject,Codable {

    
    ///From api response key if changed
       enum apiKey: String, CodingKey {
           case genreID = "id"
           case name
       }
    
       // MARK: - Decodable
       required convenience public init(from decoder: Decoder) throws {
           
           ///Fetch context for codable
           guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
               let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
               let manageObjList = NSEntityDescription.entity(forEntityName: "Genres", in: manageObjContext) else {
                   fatalError("failed")
           }
           
           self.init(entity: manageObjList, insertInto: manageObjContext)
        
           let container = try decoder.container(keyedBy: apiKey.self)
           self.genreID = try (container.decodeIfPresent(Int64.self, forKey: .genreID) ?? 0)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
       }
    
}
