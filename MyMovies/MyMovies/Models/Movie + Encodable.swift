//
//  Movie + Encodable.swift
//  MyMovies
//
//  Created by Julian A. Fordyce on 2/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


extension Movie: Encodable {
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case identifier
        case hasWatched
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(hasWatched, forKey: .hasWatched)
    }
}
