//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate, MovieTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        movieController.searchForMovie(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func addMovieButtonWasTapped(on cell: SearchedMoviesTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let movie = movieController.searchedMovies[indexPath.row]
        movieController.create(title: movie.title)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! SearchedMoviesTableViewCell
        let movie = movieController.searchedMovies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.delegate = self
        
        return cell
    }
    
    
    
    var movieController = MovieController()
    
    @IBOutlet weak var searchBar: UISearchBar!
}
