//
//  APIMovieTableViewCell.swift
//  MyMovies
//
//  Created by Kenny on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class APIMovieTableViewCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var addMovieButton: UIButton!
    
    //MARK: IBActions
    @IBAction func movieWatchedButtonWasTapped(_ sender: Any) {        
        guard let movieRepresentation = movieRepresentation else {return}
        //setup button UI, gracefully inform user of change
        #warning("There are better ways to avoid duplication. This check only does it in the case of the movie having just been added. There's no check to prevent movies in CoreData from being added to CoreData again on subsequent search iterations, and there should be in the final product")
        if addMovieButton.currentTitle != addedText {
            //save to CoreData
            movieController?.updateMovies(with: [movieRepresentation])
            guard let movie = Movie(movieRepresentation: movieRepresentation) else {return}
            addMovieButton.alpha = 0
            addMovieButton.setTitle(addedText, for: .normal) //TODO: compare to CoreData object hasWatched
            UIView.animate(withDuration: 0.5) {
                self.addMovieButton.alpha = 1
            }
            //put to Firebase
            movieController?.put(movie: movie) { error in
                if error != nil {
                    print(error as Any)
                }
            }
        } else {
            //TODO: Alert
        }
        
    }
    //MARK: Properties
    private let addedText = "Added!"
    private let addMovieText = "Add To My List"
    var movieController: MovieController?
    
    var movieRepresentation: MovieRepresentation? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: Methods
    func updateViews() {
        guard let movie = movieRepresentation else {return}
        if movie.hasWatched ?? false {
            addMovieButton.setTitle(addedText, for: .normal)
        } else {
            addMovieButton.setTitle(addMovieText, for: .normal)
        }
        movieNameLabel.text = movie.title
    }

}
