//
//  MovieSearchTableViewCell.swift
//  MyMovies
//
//  Created by Nelson Gonzalez on 2/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addMovieButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    @IBAction func addMoviewButtonPressed(_ sender: UIButton) {
    }
    
}
