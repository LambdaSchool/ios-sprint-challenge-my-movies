//
//  MyMoviesTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class MyMoviesTableViewController: UITableViewController {
    
    let movieController = MovieController()
    let apiController = APIController()
    
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Movies> = {
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true),
            NSSortDescriptor(key: "hasWatched", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: moc,
            sectionNameKeyPath: "hasWatched",
            cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.editButtonItem
        // Uncomment the following line to preserve selection between presentations
        
        // self.clearsSelectionOnViewWillAppear = true
        
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movies = fetchedResultsController.object(at: indexPath)
            DispatchQueue.main.async {
                self.movieController.delete(movie: movies)
                let moc = CoreDataStack.shared.mainContext
                    do {
                        try moc.save()
                        tableView.reloadData()
                    } catch {
                        moc.reset()
                        print("Error saving: \(error)")
                        tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMovieCell", for: indexPath)
        let movie = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = movie.title
        
        if movie.hasWatched == true {
            cell.detailTextLabel?.text = "Watched"
        } else if movie.hasWatched == false {
            cell.detailTextLabel?.text = "Not Watched"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return nil }

        if sectionInfo.name == "0" {
            return "Not Watched"
        } else {
            return "Watched"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMovieCell", for: indexPath)
        let movie = fetchedResultsController.object(at: indexPath)
        
          if movie.hasWatched == true {
            cell.detailTextLabel?.text = "Watched"
            movie.hasWatched = false
            movieController.update(movie: movie)
        } else if movie.hasWatched == false {
            cell.detailTextLabel?.text = "Not Watched"
            movie.hasWatched = true
            movieController.update(movie: movie)
            
        }
    }
    
    @objc func updateWatchStatus(button: UIButton) {
          DispatchQueue.main.async {
            if button.titleLabel?.text == "Not Watched" {
                button.setTitle("Watched", for: .normal)
                self.movieController.save()
            } else if button.titleLabel?.text == "Watched" {
                button.setTitle("Not Watched", for: .normal)
            }
        }
    }
}


extension MyMoviesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default: return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        let sectionSet = IndexSet(integer: sectionIndex)
        switch type {
            case .insert:
                tableView.insertSections(sectionSet, with: .automatic)
            case .delete:
                tableView.deleteSections(sectionSet, with: .automatic)
            default: return
        }
        
    }
}
