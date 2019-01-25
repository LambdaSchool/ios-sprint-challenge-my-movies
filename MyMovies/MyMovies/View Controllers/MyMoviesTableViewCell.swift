//
//  MyMoviesTableViewCell.swift
//  MyMovies
//
//  Created by Ivan Caldwell on 1/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MyMoviesTableViewCell: UITableViewCell {
    // Variables
    let movieController = MovieController()
    var movie: Movie?{
        didSet {
            updateViews()
        }
    }
    
    // Outlets and Actions
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var hasWatchedButton: UIButton!
    @IBAction func hasWatchButtonTapped(_ sender: Any) {
        guard let movie = movie else { return }
        movie.hasWatched = !movie.hasWatched
        movieController.saveToPersistentStore()
        movieController.put(movie: movie)
        updateViews()
        print("Hello")
    }
    
    // Functions
    func updateViews(){
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.title
        hasWatchedButton.setTitle(movie.hasWatched ? "Watched" : "Unwatched", for: .normal)
    }
    
    
}
