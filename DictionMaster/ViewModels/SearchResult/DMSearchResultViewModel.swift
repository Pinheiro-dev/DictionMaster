//
//  DMSearchResultViewModel.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit
import AVFoundation

protocol DMSearchResultViewModelDelegate: AnyObject {
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?)
    func playAudio()
    var title: String? { get }
    var titleBottom: String? { get }
    var phonetic: String? { get }
    var definition: NSMutableAttributedString? {get}
}

final class DMSearchResultViewModel: NSObject, DMSearchResultViewModelDelegate {
    var title: String?
    var titleBottom: String?
    var phonetic: String?
    var definition: NSMutableAttributedString?
    
    var audio: String?
    private var player: AVAudioPlayer?
    private var result: [DictionaryModel]
    private var resultFormatted: WordDefinitionModel?
    private let api: DMServiceManagerProtocol = DMServiceManager()
    private weak var delegate: DMSearchResultViewControllerDelegate?
    
    //MARK: - init
    
    init(result: [DictionaryModel]) {
        self.result = result
        super.init()
        self.resultFormatted = self.formatResult(with: result)
        self.setUpDelegateVariables()
    }
    
    private func setUpDelegateVariables() {
        self.title = resultFormatted?.title.capitalized
        self.phonetic = resultFormatted?.phonetic
        self.definition = resultFormatted?.definition
        self.audio = resultFormatted?.audio
        
        guard let title = title else { return }
        self.titleBottom = Localized().searchResult.thatsIt(with: title.lowercased())
    }
    
    private func getFormattedDefinitions(definitions: [MeaningDefinition]) -> NSMutableAttributedString {
        let definition = NSMutableAttributedString(string: "")
        for (index, item) in definitions.enumerated() {
            let brakeLine = index < definitions.endIndex ? "\n\n" : ""
            var examples: String
            if (item.examples.isEmpty) {
                examples = item.examples + brakeLine
            } else {
                examples = "\n\n" + item.examples + brakeLine
            }
            
            let attributedText = NSAttributedString(
                string: examples,
                attributes: [
                    NSAttributedString.Key.foregroundColor: Color().primaryColor,
                    NSAttributedString.Key.font: UIFont.SFProRounded(size: 16)
                ]
            )
            definition.append(item.definition)
            definition.append(attributedText)
        }
        
        return definition
    }
    
    private func getFomattedDefinition(partOfSpeech: String, definition: String, index: Int) -> NSMutableAttributedString {
        let speechString = " [\(partOfSpeech)] "
        let fullString = "\(index.description))" + speechString + definition
        let attributedString = fullString.attributedString(subStr: speechString,
                                                           font: .SFProRounded(.bold, size: 16),
                                                           color: Color().primaryColor.withAlphaComponent(0.50))
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
        let phonetic: String = data.phonetic ?? ""
        let phonetics: [Phonetic]? = data.phonetics
        var audio: String?
        if let phonetics = phonetics, let phonetic = phonetics.first(where: { !$0.audio.isEmpty }) {
            audio = phonetic.audio
        }
         
        
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

        let definitions = getFormattedDefinitions(definitions: item)
        
        let model = WordDefinitionModel(title: title,
                                        phonetic: phonetic,
                                        audio: audio,
                                        definition: definitions)

        return model
    }
    
    private func playSound(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
        } catch {
            self.delegate?.didAudioFailed(errorTitle: Localized().error.genericTitleAudio,
                                          errorMessage: Localized().error.genericMessage)
        }
        self.delegate?.didAudioPlayed()
    }
    
    
    //MARK: - Actions
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func playAudio() {
        guard let audio = audio, let url = URL(string: audio) else {
            self.delegate?.didAudioFailed(errorTitle: Localized().error.genericTitleAudio,
                                          errorMessage: Localized().error.genericMessage)
            return
        }
        self.api.downloadAudio(with: url) { result in
            switch result {
            case .success(let urlAudio):
                self.playSound(url: urlAudio)
            case .failure(_):
                self.delegate?.didAudioFailed(errorTitle: Localized().error.genericTitleAudio,
                                              errorMessage: Localized().error.genericMessage)
            }
        }
    }
    
}
