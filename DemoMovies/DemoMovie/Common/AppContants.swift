//
//  AppConstants.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

struct AppConstants {
    
    struct APIUrl {
        static let baseURL        = "https://api.themoviedb.org"
        static let apiVersion     = "/3"
        static let apiVersionNew  = "/4"
        static let imageURL       = "https://image.tmdb.org/t/p/"
        
        static let apiKey     = "1d552d5ffe2a0f53b3a219319e0cf9a9"
        static let authToken  = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDU1MmQ1ZmZlMmEwZjUzYjNhMjE5MzE5ZTBjZjlhOSIsInN1YiI6IjVlNWQ1MTcyMzU3YzAwMDAxOTJjNGEwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tuiUh5U7BaBpFKa218lHmMbm_xXPDw9lEkvKuFls6t4"
        
        static let moviesList     = "\(baseURL)\(apiVersionNew)/list/1?page=1&api_key=\(apiKey)"
        static let moviesDetails  = "\(baseURL)\(apiVersion)/movie/"
        
        // "/movie/284053?api_key=1d552d5ffe2a0f53b3a219319e0cf9a9"

    }
    
}
