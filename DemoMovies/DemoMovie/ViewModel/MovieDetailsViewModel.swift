//
//  MovieDetailsViewModel.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation
import CoreData

class MovieDetailsViewModel {
    
    var dataDetails:MovieDetails?
    
    
    func dataSetup(movieId:String) {
        do {
            self.dataDetails = try  self.fetchMoviesFromLocalData(movieId: movieId)
        }
        catch{
           self.dataDetails = nil
        }
    }
    
    
    // MARK: - FETCH MOVIE DETAILS
        
    func fetchMoviesFromLocalData(movieId:String) throws -> MovieDetails? {
           let manageObjContext = appDelegate.persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
          fetchRequest.predicate = NSPredicate(format: "id = %@", movieId)
           let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)

           fetchRequest.sortDescriptors = [sortDescriptor]
           do {
               let arrayOfList = try manageObjContext.fetch(fetchRequest)
            if arrayOfList.count > 0 {
                return arrayOfList[0]
            }
            return nil
           } catch let error {
               throw error
           }
       }
       
}
