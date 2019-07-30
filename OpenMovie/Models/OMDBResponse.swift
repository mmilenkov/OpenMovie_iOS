//
//  OMDBResponse.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

struct OMDBResponse: Codable {
    let Title: String
    let Year: String
    let Genre: String
    let Runtime: String
    let Poster: String
    let imdbRating: String
    let Actors: String
    let Plot: String
}

extension OMDBResponse: MovieData {
    
}
