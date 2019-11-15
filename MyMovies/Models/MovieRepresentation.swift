//
//  MovieRepresentation.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import CoreData

struct MovieRepresentation: Equatable, Codable {
    let title: String
    
    /*
     identifier and hasWatched are not a part of The Movie DB API, however they will be used both on Firebase and on the application itself.
     In order make the MovieRepresentation struct decode properly when fetching from the API, their types should stay optional.
     */
    
    let identifier: UUID?
    let hasWatched: Bool?
}

/*
 Represents the full JSON returned from searching for a movie.
 The actual movies are in the "results" dictionary of the JSON.
 */
struct MovieRepresentations: Codable {
    let results: [MovieRepresentation]
}

extension Movie {
    var movieRepresentation: MovieRepresentation? {
        guard let title = self.title,
            let identifier = self.identifier
            else {
                print("Cannot get movie's representation; `title` and/or `identefier` missing!")
                return nil
        }
        return MovieRepresentation(title: title, identifier: identifier, hasWatched: self.hasWatched)
    }
    
    convenience init?(representation: MovieRepresentation, context: NSManagedObjectContext) {
        self.init(context: context)

        self.title = representation.title
        self.hasWatched = representation.hasWatched ?? false
        self.identifier = representation.identifier ?? UUID()
    }
}
