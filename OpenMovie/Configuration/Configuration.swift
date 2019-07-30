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
}
