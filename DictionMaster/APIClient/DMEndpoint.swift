//
//  DMEndpoint.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

/// Represents unique API endpoint
@frozen enum DMEndpoint: String {
    /// Enpoint to get word info
    case entries
    /// Enpoint to get pronunciation mp3
    case pronunciations
}
