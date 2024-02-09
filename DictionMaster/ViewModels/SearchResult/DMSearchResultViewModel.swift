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
    func getInstance() -> NSObject
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?)
    func playAudio()
    var title: String? { get }
    var titleBottom: String? { get }
    var phonetic: String? { get }
}

final class DMSearchResultViewModel: NSObject, DMSearchResultViewModelDelegate {
    var title: String?
    var titleBottom: String?
    var phonetic: String?
    
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
        self.audio = resultFormatted?.audio
        
        guard let title = title else { return }
        self.titleBottom = "That’s it for “\(title.lowercased())”!"
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
        
        let model = WordDefinitionModel(title: title,
                                        phonetic: phonetic,
                                        audio: audio,
                                        item: item)

        return model
    }
    
    private func playSound(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
        } catch {
            self.delegate?.didAudioFailed(errorTitle: "Failed to play pronunciation",
                                          errorMessage: "Sorry pal, you can try again at later time.")
        }
    }
    
    
    //MARK: - Actions
    
    func getInstance() -> NSObject {
        return self
    }
    
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func playAudio() {
        guard let audio = audio, let url = URL(string: audio) else {
            self.delegate?.didAudioFailed(errorTitle: "Failed to play pronunciation",
                                          errorMessage: "Sorry pal, you can try again at later time.")
            return
        }
        self.api.downloadAudio(with: url) { result in
            switch result {
            case .success(let urlAudio):
                self.playSound(url: urlAudio)
            case .failure(_):
                self.delegate?.didAudioFailed(errorTitle: "Failed to play pronunciation",
                                              errorMessage: "Sorry pal, you can try again at later time.")
            }
        }
    }
    
}

//MARK: - TableViewDelegate e TableViewDataSource

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