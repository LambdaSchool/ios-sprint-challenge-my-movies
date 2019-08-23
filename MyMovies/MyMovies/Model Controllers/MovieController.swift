//
//  MovieController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MovieController {
	
	// MARK: - Properties
	
	var searchedMovies: [MovieRepresentation] = []
    
    private let apiKey = "4cc920dab8b729a619647ccc4d191d5e"
    private let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")!
	
	//MARK: - CRUD
	
//	func createEntry(for movie: Movie) {
//		CoreDataStack.shared.mainContext.performAndWait {
//			do {
//				try CoreDataStack.shared.save()
//			} catch {
//				NSLog("Error saving context when creating a new task")
//			}
//			putInDB(entry: entry)
//		}
//	}
	
	func update(movie: Movie, hasWatched: Bool) {
		movie.hasWatched = hasWatched
		
		CoreDataStack.shared.mainContext.performAndWait {
			do {
				try CoreDataStack.shared.save()
			} catch {
				NSLog("Error saving context when updating a new task")
			}
		}
		putInDB(movie: Movie)
	}
	
	func delete(movie: Movie) {
		deleteFromDB(movie: Movie)
		let moc = CoreDataStack.shared.mainContext
		
		moc.performAndWait {
			moc.delete(movie)
			do {
				try CoreDataStack.shared.save()
			} catch {
				NSLog("Error saving context when deleting a new task")
			}
		}
		
	}
}
	
//MARK: - Networking

extension MovieController {
	
    func searchForMovie(with searchTerm: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryParameters = ["query": searchTerm,
                               "api_key": apiKey]
        
        components?.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let requestURL = components?.url else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching for movie with search term \(searchTerm): \(error)")
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieRepresentations = try JSONDecoder().decode(MovieRepresentations.self, from: data).results
                self.searchedMovies = movieRepresentations
                completion(.success(true))
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(.failure(.notDecoding))
            }
        }.resume()
    }
}
