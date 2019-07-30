//
//  MovieViewModel.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
    private var movieData: MovieData
    private var replacedActors: String
    
    var image: UIImage?
    var title: String {
        return movieData.Title
    }
    var plot: String {
        return movieData.Plot
    }
    var actors: [String] {
        return replacedActors.split(separator: "/").map { String($0) }
    }
    var score: String {
        return movieData.imdbRating
    }
    
    var details: String {
        return "\(movieData.Year) ● \(movieData.Genre.replacingOccurrences(of: ", ", with: "/")) ● \(movieData.Runtime)"
    }
    
    init(movieData: MovieData) {
        self.movieData = movieData
        replacedActors = movieData.Actors.replacingOccurrences(of: ", ", with: "/")
        fetchImage()
    }
    
    
    private func fetchImage() {
        let imageURL = URL(string: movieData.Poster)
        
        if let url = imageURL {
            do {
                let imageData = try Data(contentsOf: url)
                self.image = UIImage(data: imageData)
            } catch {
                print("error loading image")
                self.image = nil
            }
        }
    }
    
}
