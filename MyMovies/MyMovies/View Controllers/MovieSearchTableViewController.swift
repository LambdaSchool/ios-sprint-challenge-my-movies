//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate, MovieSearchTableViewCellDelegate {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // MARK: - Search Bar Action
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        movieController.searchForMovie(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell()}
        
        let movieRepresentation = movieController.searchedMovies[indexPath.row]
        
        cell.movieRepresentation = movieRepresentation
        
        return cell
    }
    
    // MARK: Cell Delegate
    
    func addMovieTapped(on cell: MovieSearchTableViewCell) {
        <#code#>
    }
    
    // MARK: - Properties
    
    var movieController = MovieController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
}
