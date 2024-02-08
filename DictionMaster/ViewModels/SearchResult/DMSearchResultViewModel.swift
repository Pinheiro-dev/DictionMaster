//
//  DMSearchResultViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

protocol DMSearchResultViewModelDelegate: AnyObject {
    func getInstance() -> NSObject
    var title: String? { get }
    var phonetic: String? { get }
    var audio: String? { get }
}

final class DMSearchResultViewModel: NSObject, DMSearchResultViewModelDelegate {
    var title: String?
    var phonetic: String?
    var audio: String?
    
    private var result: [DictionaryModel]
    
    private var resultFormatted: WordDefinitionModel?
    
    init(result: [DictionaryModel]) {
        self.result = result
        super.init()
        self.resultFormatted = self.formatResult(with: result)
        self.title = resultFormatted?.title
        self.phonetic = resultFormatted?.phonetic
        self.audio = resultFormatted?.audio
    }
    
    private func getFomattedDefinition(partOfSpeech: String, definition: String, index: Int) -> NSMutableAttributedString {
        let speechString = " [\(partOfSpeech)] "
        let fullString = "\(index.description))" + speechString + definition
        let attributedString = fullString.attributedString(subStr: speechString,
                                                           font: .SFProRounded(.bold, size: 16),
                                                           color: .init(hexString: "#052D39").withAlphaComponent(0.50))
        return attributedString
    }
    
    private func getFormattedExamples(examples: [String]) -> String {
        var fullString = ""
        examples.forEach { text in
            fullString += "• \(text)\n"
        }
        return fullString
    }
    
    private func formatResult(with result: [DictionaryModel]) -> WordDefinitionModel {
        let data = result[0]
        let title = data.word
        var phonetic: String = data.phonetic ?? ""
        var audio: String? = data.phonetics?.first?.audio
        
        let item: [MeaningDefinition] = data.meanings.enumerated().compactMap({ index, element in
            let partOfSpeech = element.partOfSpeech;
            let definitions = element.definitions
            
            let examplesArray: [String] = definitions.compactMap{ $0.example }
            let examples = getFormattedExamples(examples: examplesArray)
            let definition = getFomattedDefinition(partOfSpeech: partOfSpeech,
                                                   definition: definitions[0].definition,
                                                   index: index+1)
            
            
            return MeaningDefinition(definition: definition,
                                     examples: examples)
        })
        
        let model = WordDefinitionModel(title: title,
                                        phonetic: phonetic,
                                        audio: audio,
                                        item: item)

        return model
    }
    
    //MARK: - Actions
    
    func getInstance() -> NSObject {
        return self
    }
}


extension DMSearchResultViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFormatted?.item.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = resultFormatted,
              let cell = tableView.dequeueReusableCell(withIdentifier: DMSearchResultTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DMSearchResultTableViewCell
        else {
            return UITableViewCell()
        }
        
        let item = data.item[indexPath.row]

        cell.definitionLabel.attributedText = item.definition
        cell.examplesLabel.text = item.examples
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
