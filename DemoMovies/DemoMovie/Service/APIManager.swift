//
//  APIManager.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.


import Foundation
import Alamofire
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class APIManager: NSObject {
    
    //MARK: Singleton
    static let shared = APIManager()
    private override init() {}
    
    let queue = DispatchQueue(label: "com.demo.DemoMovies", qos: .utility, attributes: [.concurrent])
    
    var sessionManager: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        return manager
    }
    
    
    enum APIError: Error {
        case JSONSerialization
        case responseData
        case nilJson
        case timeOut
    }
    
    //MARK: FETCH MOVIE LIST

    func getMoviesList(completionHandler: @escaping (_ result: [String: Any]?, _ error: Error?) -> Void) {
        let urlString = AppConstants.APIUrl.moviesList
        sessionManager.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in
                    DispatchQueue.main.async {
                    }
                    switch (response.result) {
                    case .success: // succes path
                        do {
                            guard let data = response.data else {
                                completionHandler(nil, APIError.responseData)
                                return
                            }
                            let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                            DispatchQueue.main.async {
                                guard let json = json else {
                                    completionHandler(nil, APIError.nilJson)
                                    return
                                }
                                guard let results = json["results"] as? [[String:Any]] else {
                                    return
                                }
                                print(results)
                                if let theJSONData = try? JSONSerialization.data(
                                withJSONObject: results,
                                options: []) {
                                    self.parseMovieListResponse(forData: theJSONData)
                                }
                                completionHandler(json, nil)
                            }
                        } catch _ as NSError {
                            DispatchQueue.main.async {
                                completionHandler(nil, APIError.JSONSerialization)
                            }
                        }
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            print("Request timeout!")
                            completionHandler(nil, APIError.timeOut)
                        }
                        print(error.localizedDescription)
                    }
                    
            })
    }
    
    
     ///parse response using decodable and store data
    func parseMovieListResponse(forData jsonData : Data)  {
        do {
            guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                fatalError("Failed context")
            }
            let manageObjContext = appDelegate.persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codableContext] = manageObjContext
            // Parse JSON data
            _ = try decoder.decode([Movies].self, from: jsonData)
            ///context save
            try manageObjContext.save()
            UserDefaults.standard.set(true, forKey: "isAllreadyFetch")
            UserDefaults.standard.synchronize()
        } catch let error {
            print("Error ->\(error.localizedDescription)")
           // self.errorMessage(error.localizedDescription)
        }
    }
    
    //MARK: FETCH MOVIE DETAILS

    
    func getMoviesDetails(movieId:String ,completionHandler: @escaping (_ result: [String: Any]?, _ error: Error?) -> Void) {
        let urlString = AppConstants.APIUrl.moviesDetails + movieId + "?api_key=\(AppConstants.APIUrl.apiKey)" 
        sessionManager.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in
                    DispatchQueue.main.async {
                    }
                    switch (response.result) {
                    case .success: // succes path
                        do {
                            guard let data = response.data else {
                                completionHandler(nil, APIError.responseData)
                                return
                            }
                            let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                            DispatchQueue.main.async {
                                guard let json = json else {
                                    completionHandler(nil, APIError.nilJson)
                                    return
                                }
                                if let theJSONData = try? JSONSerialization.data(
                                withJSONObject: json,
                                options: []) {
                                    self.parseMovieDetailsResponse(forData: theJSONData)
                                }
                                completionHandler(json, nil)
                            }
                        } catch _ as NSError {
                            DispatchQueue.main.async {
                                completionHandler(nil, APIError.JSONSerialization)
                            }
                        }
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            print("Request timeout!")
                            completionHandler(nil, APIError.timeOut)
                        }
                        print(error.localizedDescription)
                    }
                    
            })
    }
    

    ///parse response using decodable and store data
       func parseMovieDetailsResponse(forData jsonData : Data)  {
           do {
               guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                   fatalError("Failed context")
               }
               let manageObjContext = appDelegate.persistentContainer.viewContext
               let decoder = JSONDecoder()
               decoder.userInfo[codableContext] = manageObjContext
               // Parse JSON data
               _ = try decoder.decode(MovieDetails.self, from: jsonData)
               ///context save
               try manageObjContext.save()
               UserDefaults.standard.synchronize()
           } catch let error {
               print("Error ->\(error.localizedDescription)")
              // self.errorMessage(error.localizedDescription)
           }
       }
    
}
