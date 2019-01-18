//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate, MovieSearchTableViewCellDelegate {
    
    func saveMovieToList(cell: MovieSearchTableViewCell) {
        //guard let movie = movie,
            //let movieRepresentation = movieRepresentation else { return }
        let moc = CoreDataStack.shared.mainContext
        let _ = Movie(context: moc)
        //savedMovie.title = cell.MovieTitleLabel?.text
        
        do {
            try moc.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieSearchTableViewCell
        
        let movie = movieController.searchedMovies[indexPath.row].title
        cell.textLabel?.text = movie
        cell.delegate = self
        
        return cell
    }
    
    let movie: Movie? = nil
    var movieController = MovieController()
    var movieRepresentation: MovieRepresentation?
    
    @IBOutlet weak var searchBar: UISearchBar!
}
