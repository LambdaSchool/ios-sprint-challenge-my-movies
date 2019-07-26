//
//  SearchMovieTableViewCellDelegate.swift
//  MyMovies
//
//  Created by Nathan Hedgeman on 7/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol SearchMovieTableViewCellDelegate: class {
    
    func saveMovieToMyMovies(for cell: SearchMovieTableViewCell)
    
}
