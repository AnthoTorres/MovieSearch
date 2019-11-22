//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Anthony Torres on 11/22/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func updateView(movie: Movie) {
        
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "Rating: \(movie.rating)"
        movieDescriptionLabel.text = movie.description
        
        moviePosterImageView.image = UIImage(named: "defaultPoster")
        guard let posterPath = movie.postPath
            else { return }
        MovieSearchController.fetchMoviePosterFor(path: posterPath) { image in
            DispatchQueue.main.async {
                if let posterImage = image {
                    self.moviePosterImageView.image = posterImage
                }
            }
        }
    }
}
