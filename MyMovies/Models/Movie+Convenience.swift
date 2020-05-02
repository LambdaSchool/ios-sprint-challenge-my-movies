//
//  Movie+Convenience.swift
//  MyMovies
//
//  Created by Chad Parker on 5/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Movie {
    
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        title: String,
                                        hasWatched: Bool,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.identifier = identifier
        self.title = title
        self.hasWatched = hasWatched
    }
    
    @discardableResult convenience init?(movieRepresentation: MovieRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let identifier = UUID(uuidString: movieRepresentation.identifier) else { fatalError() }
        
        self.init(identifier: identifier,
                   title: movieRepresentation.title,
                   hasWatched: movieRepresentation.hasWatched,
                   context: context)
    }
    
    var movieRepresentation: MovieRepresentation? {
        guard let title = title,
            let identifier = identifier?.uuidString else { return nil }
        
        return MovieRepresentation(title: title,
                                   identifier: identifier,
                                   hasWatched: hasWatched)
    }
}
