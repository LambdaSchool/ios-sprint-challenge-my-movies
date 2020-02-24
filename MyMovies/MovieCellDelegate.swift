//
//  MovieCellDelegate.swift
//  MyMovies
//
//  Created by Joshua Rutkowski on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol MovieCellDelegate {
    func buttonTapped(for movie: Movie)
}
