//
//  MovieDetails+CoreDataProperties.swift
//  DemoMovies
//
//  Created by Vijay A on 04/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetails> {
        return NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
    }

    @NSManaged public var budget: String?
    @NSManaged public var id: Int64
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var revenue: Int64
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int64
    @NSManaged public var runtime: Int64
    @NSManaged public var backdrop_path: String?
    @NSManaged public var language: NSSet?
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for language
extension MovieDetails {

    @objc(addLanguageObject:)
    @NSManaged public func addToLanguage(_ value: Languages)

    @objc(removeLanguageObject:)
    @NSManaged public func removeFromLanguage(_ value: Languages)

    @objc(addLanguage:)
    @NSManaged public func addToLanguage(_ values: NSSet)

    @objc(removeLanguage:)
    @NSManaged public func removeFromLanguage(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension MovieDetails {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genres)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genres)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
