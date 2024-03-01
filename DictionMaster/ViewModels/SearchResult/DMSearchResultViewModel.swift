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
    func getInstance() -> NSObject & UITableViewDelegate & UITableViewDataSource
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?)
    func setHeaderDelegate(_ delegate: DMSerachResultFooterViewDelegate?)
    func playAudio()
}

protocol DMSearchResultHeaderFooterDelegate: AnyObject {
    func didClick(with type: ViewType)
}

enum ViewType {
    case header
    case footer
}

//MARK: - ViewModel

final class DMSearchResultViewModel: NSObject, DMSearchResultViewModelDelegate {
    
    private var audio: String?
    private var player: AVAudioPlayer?
    private var result: [DictionaryModel]
    private var resultFormatted: WordDefinitionModel?
    private let api: DMServiceManagerProtocol = DMServiceManager()
    private weak var delegate: DMSearchResultViewControllerDelegate?
    private weak var headerDelegate: DMSerachResultFooterViewDelegate?
    
    //MARK: - init
    
    init(result: [DictionaryModel]) {
        self.result = result
        super.init()
        self.resultFormatted = self.formatResult(with: result)
        self.audio = resultFormatted?.audio
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
        var phonetic: String = ""
        let phonetics: [Phonetic]? = data.phonetics
        var audio: String?
        if let phonetics = phonetics, let phoneticModel = phonetics.first(where: { !$0.audio.isEmpty && ($0.text != nil) }) {
            audio = phoneticModel.audio
            phonetic = phoneticModel.text ?? data.phonetic ?? ""
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
        self.headerDelegate?.stopLoading()
    }
    
    
    //MARK: - Actions
    
    func getInstance() -> NSObject & UITableViewDelegate & UITableViewDataSource {
        return self
    }
    
    func setDelegate(_ delegate: DMSearchResultViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func setHeaderDelegate(_ delegate: DMSerachResultFooterViewDelegate?) {
        self.headerDelegate = delegate
    }
    
    func playAudio() {
        guard let audio = audio, let url = URL(string: audio) else {
            self.delegate?.didAudioFailed(errorTitle: Localized().error.genericTitleAudio,
                                          errorMessage: Localized().error.genericMessage)
            self.headerDelegate?.stopLoading()
            return
        }
        self.api.downloadAudio(with: url) { result in
            switch result {
            case .success(let urlAudio):
                self.playSound(url: urlAudio)
            case .failure(_):
                self.delegate?.didAudioFailed(errorTitle: Localized().error.genericTitleAudio,
                                              errorMessage: Localized().error.genericMessage)
                self.headerDelegate?.stopLoading()
            }
        }
    }
    
}

//MARK: - Footer e Header Delegate

extension DMSearchResultViewModel: DMSearchResultHeaderFooterDelegate {
    func didClick(with type: ViewType) {
        switch type {
        case .header:
            self.playAudio()
        case .footer:
            self.delegate?.pop()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = resultFormatted,
              let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: DMSearchResultHeaderView.identifier
              ) as? DMSearchResultHeaderView else {
            return UIView()
        }
        
        header.setDelegate(delegate: self)
        header.configViewModel(with: self)
        header.titleLabel.text = data.title.capitalized
        header.pronunciationLabel.text = data.phonetic
        return header
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 186
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let data = resultFormatted,
              let footer = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: DMSearchResultFooterView.identifier
              ) as? DMSearchResultFooterView else {
            return UIView()
        }
        
        footer.setDelegate(delegate: self)
        footer.titleBottomLabel.text = Localized().searchResult.thatsIt(with: data.title.lowercased())
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 214.5
    }

}
