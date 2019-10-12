//
//  MyMoviesController.swift
//  MyMovies
//
//  Created by Joel Groomer on 10/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class MyMoviesController {
    let baseURL = URL(string: "https://lambda-my-movies.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void
    
    
    // MARK: - Local Store Methods
    
    func addMovie(representation: MovieRepresentation) {
        guard let movie = Movie(representation: representation) else { return }
        
        put(movie: movie)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            print("Error saving new movie: \(error)")
        }
    }
    
    func toggleSeen(movie: Movie) {
        do {
            movie.hasWatched.toggle()
            try CoreDataStack.shared.save()
        } catch {
            print("Error toggling: \(error)")
        }
        
        put(movie: movie)
        
    }
    
    func toggleSeen(representation: MovieRepresentation) {
        guard let movie = Movie(representation: representation) else { return }
        toggleSeen(movie: movie)
    }
    
    func deleteMovie(movie: Movie, completion: @escaping CompletionHandler = { _ in }) {
        deleteFromServer(movie: movie) { (error) in
            if let error = error {
                print("Will not delete local copy")
                completion(error)
                return
            } else {
                CoreDataStack.shared.mainContext.delete(movie)
                do {
                    try CoreDataStack.shared.save()
                } catch {
                    print("Error saving after delete: \(error)")
                }
                completion(nil)
            }
        }
    }
    
    func update(movie: Movie, with representation: MovieRepresentation) {
        
    }
    
    func updateMovies(with representations: [MovieRepresentation]) {
        
    }
    
    
    // MARK: - Server Methods
    
    private func put(movie: Movie, completion: @escaping CompletionHandler = { _ in }) {
        
    }
    
    private func deleteFromServer(movie: Movie, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = movie.identifier else {
            completion(nil)
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error deleting movie from server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
}
