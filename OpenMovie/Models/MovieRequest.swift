//
//  MovieRequest.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

struct MovieRequest {
    let baseURL: URL
    let title: String
    
    var url: URL {
        var intermediary = baseURL.absoluteString
        intermediary += title
        return URL(string: intermediary)!
    }
    
}
