//
//  Movies+CoreDataClass.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movies)
public class Movies: NSManagedObject, Codable{

    ///From api response key if changed
    enum apiKey: String, CodingKey {
        case id
        case overview
        case poster_path
        case title
        case vote_average
    }
    


    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        ///Fetch context for codable
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "Movies", in: manageObjContext) else {
                fatalError("failed")
        }
        
        self.init(entity: manageObjList, insertInto: manageObjContext)
        
        let container = try decoder.container(keyedBy: apiKey.self)
        self.id = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.vote_average = try (container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0)
    }
}
