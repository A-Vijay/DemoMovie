//
//  MoviesViewModel.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation
import CoreData

class MoviesViewModel {
    
    var dataItems:[Movies] = []
    var allItems:[Movies] = []
    
    init() {
        self.dataSetup()
    }
    
    func dataSetup() {
        do {
           self.dataItems = try  self.fetchMoviesFromLocalData()
           self.allItems = dataItems
        }
        catch{
           self.dataItems = [Movies]()
        }
    }
    
    
    // MARK: - FETCH MOVIES
        
       func fetchMoviesFromLocalData() throws -> [Movies] {
           let manageObjContext = appDelegate.persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<Movies>(entityName: "Movies")
           let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
           do {
               let arrayOfList = try manageObjContext.fetch(fetchRequest)
              return arrayOfList

           } catch let error {
               throw error
           }
       }
    
    // MARK: - FILTER MOVIES
    
    func filterMovies(searchedText:String){
        self.dataItems = self.allItems.filter{
            if let movieName = $0.title?.lowercased() {
                return movieName.contains(searchedText.lowercased())
            }
            return false
        }
    }

       
}
