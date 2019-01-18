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
    
    // MARK: - API Methods
    
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
    
    // MARK: - Firebase Methods
    
    
    
    // MARK: - CRUD Methods
    
    func create(movieRepresentation: MovieRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        let hasWatched = movieRepresentation.hasWatched ?? false
        let identifier = movieRepresentation.identifier ?? UUID()
        let movie = Movie(title: movieRepresentation.title, identifier: identifier, hasWatched: hasWatched, context: context)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context\(error)")
        }
        
        //put(movie: movie)
    }
    
    func updateWatchedButton(movie: MovieRepresentation) {
        guard var watched = movie.hasWatched else { return }
        watched = !watched
        //put(movie: movie)
        
    }
    
    // MARK: - Properties
    var movieRepresentation: MovieRepresentation?
    var searchedMovies: [MovieRepresentation] = []
}
