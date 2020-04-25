//
//  MovieRepresentation.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct MovieRepresentation: Equatable, Codable {
    let title: String
    var identifier: UUID?
    var hasWatched: Bool?
}


struct MovieRepresentations: Codable {
    let results: [MovieRepresentation]
}
