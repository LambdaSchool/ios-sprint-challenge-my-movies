//
//  Movie+Convenience.swift
//  MyMovies
//
//  Created by Waseem Idelbi on 5/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Movie {

    convenience init(title: String, hasWatched: Bool = false, identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.hasWatched = hasWatched
        self.identifier = identifier
    }
    
    
    
}
