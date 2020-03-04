//
//  Languages+CoreDataClass.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Languages)
public class Languages: NSManagedObject,Codable {

///From api response key if changed
   enum apiKey: String, CodingKey {
       case iso_639_1
       case name
   }
    
   // MARK: - Decodable
   required convenience public init(from decoder: Decoder) throws {
       
       ///Fetch context for codable
       guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
           let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
           let manageObjList = NSEntityDescription.entity(forEntityName: "Languages", in: manageObjContext) else {
               fatalError("failed")
       }
       
       self.init(entity: manageObjList, insertInto: manageObjContext)
    
       let container = try decoder.container(keyedBy: apiKey.self)
       self.iso_639_1 = try (container.decodeIfPresent(String.self, forKey: .iso_639_1))
       self.name = try container.decodeIfPresent(String.self, forKey: .name)
   }

}
