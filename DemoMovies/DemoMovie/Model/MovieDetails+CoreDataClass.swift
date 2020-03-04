//
//  MovieDetails+CoreDataClass.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MovieDetails)
public class MovieDetails: NSManagedObject , Codable{

    ///From api response key if changed
    enum apiKey: String, CodingKey {
        case budget
        case id
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case revenue
        case tagline
        case title
        case vote_average
        case vote_count
        case language = "spoken_languages"
        case genres
        case runtime
        case backdrop_path
    } 
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        ///Fetch context for codable
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "MovieDetails", in: manageObjContext) else {
                fatalError("failed")
        }
        
        self.init(entity: manageObjList, insertInto: manageObjContext)
        
        let container = try decoder.container(keyedBy: apiKey.self)
        self.id = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.popularity = try (container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0)
        self.original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.revenue = try (container.decodeIfPresent(Int64.self, forKey: .revenue) ?? 0)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.vote_average = try (container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0)
        self.vote_count = try (container.decodeIfPresent(Int64.self, forKey: .vote_count) ?? 0)
        self.runtime = try (container.decodeIfPresent(Int64.self, forKey: .runtime) ?? 0)
        self.language = NSSet(array: try (container.decodeIfPresent([Languages].self, forKey: .language) ?? []))
        self.genres = NSSet(array: try (container.decodeIfPresent([Genres].self, forKey: .genres) ?? []))

    }
}
