//
//  MovieSearchTableViewController.swift
//  Movie
//
//  Created by Anthony Torres on 11/22/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController {
    
    var movie = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.tableView.reloadData()
            }
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up a seachbar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.isActive = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        // hack to hide empty cells
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            print("Could not cast movieCell as MovieTableViewCell")
            return UITableViewCell()
        }
        
        let movies = movie[indexPath.row]
        cell.updateView(movie: movies)
        
        return cell
    }
}

// MARK: - Search Bar Delegate Methods

extension MovieSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text,!searchText.isEmpty
            else { return }
        
        MovieSearchController.findMoviesMatching(searchTerm: searchText) { movies in
            self.movie = movies
        }
    }
}
