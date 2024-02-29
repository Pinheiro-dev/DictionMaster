//
//  WordDefinitionModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation

struct WordDefinitionModel {
    let title: String
    let phonetic: String
    let audio: String?
    let definition: NSMutableAttributedString
    
    init(title: String, phonetic: String, audio: String?, definition: NSMutableAttributedString) {
        self.title = title
        self.phonetic = phonetic
        self.audio = audio
        self.definition = definition
    }
}

struct MeaningDefinition {
    let definition: NSMutableAttributedString
    let examples: String
    
    init(definition: NSMutableAttributedString, examples: String) {
        self.definition = definition
        self.examples = examples
    }
}
