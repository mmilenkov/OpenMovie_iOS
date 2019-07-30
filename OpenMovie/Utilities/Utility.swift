//
//  Utility.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

class Utility {
    static func sanitizeString(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "%20")
    }
}
