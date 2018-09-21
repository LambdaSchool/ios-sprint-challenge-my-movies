//
//  MovieController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class MovieController {
    
    private let apiKey = "4cc920dab8b729a619647ccc4d191d5e"
    private let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")!
    
    func searchForMovie(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryParameters = ["query": searchTerm,
                               "api_key": apiKey]
        
        components?.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching for movie with search term \(searchTerm): \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let movieRepresentations = try JSONDecoder().decode(MovieRepresentations.self, from: data).results
                self.searchedMovies = movieRepresentations
                completion(nil)
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(movie: Movie, completion: @escaping (Error?) -> Void = {_ in}) {
        
        let requestURL = databaseURL?.appendingPathComponent(movie.identifier?.uuidString ?? UUID().uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL!)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do { request.httpBody = try JSONEncoder().encode(movie)}
        catch{
            NSLog("Error Encoding Data: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error PUTing entry: \(error)")
                completion(error)
                return
            }
            print(response ?? "PUT successful")
            completion(nil)
            
            }.resume()
        
    }
    
    func addMovie(title: String, hasWatched: Bool = false, identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        
        let movie = Movie(title: title, hasWatched: hasWatched, identifier: identifier, context: context)
        
        do {
            try CoreDataStack.shared.save(context: context)
        } catch {
            NSLog("Error saving task: \(error)")
        }
        put(movie: movie)
    }
    
//    func createTask (with name: String, notes: String?, priority: TaskPriority, context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
//        let task = Task(name: name, notes: notes, priority: priority, context: context)
//
//        do {
//            try CoreDataStack.shared.save(context: context)
//        } catch {
//            NSLog("Error saving task: \(error)")
//        }
//
//
//        put(task: task)
//        //        saveToPersistentStore()
//    }
    
    // MARK: - Properties
    let databaseURL = URL(string: "https://mymovies-table.firebaseio.com/")
    var searchedMovies: [MovieRepresentation] = []
}
