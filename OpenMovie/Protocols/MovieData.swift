//
//  MovieData.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

protocol MovieData {
    var Title: String { get }
    var Year: String { get }
    var Genre: String { get }
    var Runtime: String { get }
    var Poster: String { get }
    var imdbRating: String { get }
    var Actors: String { get }
    var Plot: String { get }
}
