//
//  MovieSearchController.swift
//  Movie
//
//  Created by Anthony Torres on 11/22/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

import UIKit

class MovieSearchController {
    
    static let searchBaseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w300")
    
    static func findMoviesMatching(searchTerm: String, page: Int = 1, completion: @escaping ([Movie]) -> Void) {
        
        guard let baseURL = searchBaseURL else {
            print("searchBaseURL is invalid")
            completion([])
            return
        }
        
        let queries = [
            "query": searchTerm.lowercased(),
            "page": "\(page)",
            "api_key": "d5f765d3cc40d25a1ff0e9e3c1a2c1b5",
            "language": "en-US",
            "include_adult": "false"
        ]
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queries.compactMap { URLQueryItem(name: $0, value: $1) }
        
        guard let finalURL = urlComponents?.url else {
            print("Could not build final URL")
            completion([])
            return
        }
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            guard let data = data else {
                print("No Data")
                completion([])
                return
            }
            do {
                let resultsDict = try JSONDecoder().decode(TopLevelDict.self, from: data)
                completion(resultsDict.results)
                return
            } catch {
                print(error.localizedDescription)
                completion([])
                return
            }
        }
        task.resume()
    }
    
    static func fetchMoviePosterFor(path: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let baseURL = imageBaseURL else {
            print("Image base URL invalid")
            completion(nil)
            return
        }
        
        let finaUrl = baseURL.appendingPathComponent(path)
        
        let task = URLSession.shared.dataTask(with: finaUrl) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No Data")
                completion(nil)
                return
            }
            completion(UIImage(data: data, scale: 3.0))
        }
        task.resume()
    }
}
