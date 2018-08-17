//
//  MovieCell.swift
//  MyMovies
//
//  Created by Carolyn Lea on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell
{
    // MARK: - Outlets
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    
    // MARK: - Properties
    
    var movie: Movie?
    var movieController: MovieController?
    
    // MARK: - Actions
    
    @IBAction func addMovie(_ sender: Any)
    {
        do
        {
            try movieController?.saveToPersistentStore()
        }
        catch
        {
            NSLog("Error saving movie: \(error)")
        }
    }
}
