//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate, SearchTableViewCellDelegate {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func addMovie(cell: SearchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let movie = movieController.searchedMovies[indexPath.row]
        movieController.create(title: movie.title)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? SearchTableViewCell else {fatalError("Unable to dequeue cell")}
        
        let movie = movieController.searchedMovies[indexPath.row]
        cell.movie = movie
        cell.delegate = self
        
        
        return cell
    }
    
    // MARK: - Properties
    
    var movieController = MovieController()
    
    @IBOutlet weak var searchBar: UISearchBar!
}
