//
//  MyMoviesTableViewCell.swift
//  MyMovies
//
//  Created by Benjamin Hakes on 1/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MyMoviesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func changedHasBeenWatchedValue(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var movie: Movie?
    var myMoviesController: MyMoviesController?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenWatchedButton: UIButton!
    
    

}
