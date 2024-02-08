//
//  DictionaryModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation

struct DictionaryModel: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]?
}

// MARK: - License
struct License: Codable {
    let name: String
    let url: String
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let text: String
    let audio: String
    let sourceURL: String
    let license: License

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceURL = "sourceUrl"
        case license
    }
}
