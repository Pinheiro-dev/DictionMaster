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
}
