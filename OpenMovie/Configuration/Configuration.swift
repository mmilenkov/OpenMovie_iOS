//
//  Configuration.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

enum MovieService {
    private static let apiKey = "3ffcfd55"
    private static let baseURL: String = "https://www.omdbapi.com/"
    static var authenticatedBaseUrl: URL {
        return URL(string:"\(baseURL)?apikey=\(apiKey)&t=")!
    }
}

enum Constants {
    static let searchTitle = "Movie"
    static let searchMessage = "Enter the name of the movie you are looking for"
    static let movies = ["the avengers","guardians of the galaxy","guardians of the galaxy vol 2","captain america: the first avenger", "iron man", "iron man 2", "black panther","hulk", "thor","thor: ragnarok", "iron man 3", "avengers: age of ultron", "captain marvel", "captain america: civil war","captain america: the winter soldier", "spider-man: homecoming", "spider-man:far from home", "avengers: endgame","avengers: infinity war", "thor: the dark world"]
}
