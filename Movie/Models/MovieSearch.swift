//
//  MovieSearch.swift
//  Movie
//
//  Created by Anthony Torres on 11/22/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

import Foundation

struct TopLevelDict: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let postPath: String?
    let rating: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case postPath = "poster_path"
        case rating = "vote_average"
        case description = "overview"
    }
}
