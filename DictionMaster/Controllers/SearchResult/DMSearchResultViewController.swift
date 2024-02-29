//
//  DMSearchResultViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

protocol DMSearchResultViewControllerDelegate: AnyObject {
    func didAudioFailed(errorTitle: String, errorMessage: String)
    func didAudioPlayed()
}

final class DMSearchResultViewController: UIViewController {
    private let customView = DMSearchResultView()
    private let viewModel: DMSearchResultViewModelDelegate
    
    init(dictionary: [DictionaryModel]) {
        self.viewModel = DMSearchResultViewModel(result: dictionary)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden =  true
        
        viewModel.setDelegate(self)
        setupView()
        addConstraints()
        bind()
    }
    
    @objc private func onClickSearchButton(_ sender: UIButton) {
        self.navigationController?.pop()
    }
    
    @objc private func onClickAudio(_ sender: UIButton) {
        self.customView.buttonSpeaker.setLoading(true)
        self.viewModel.playAudio()
    }

    private func setupView() {
        view.addSubview(customView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bind() {
        customView.titleLabel.text = self.viewModel.title
        customView.pronunciationLabel.text = self.viewModel.phonetic
        customView.definitionLabel.attributedText = self.viewModel.definition
        customView.titleBottomLabel.text = self.viewModel.titleBottom
        
        let gestureAudio = UITapGestureRecognizer(target: self, action:  #selector(onClickAudio(_:)))
        customView.buttonSpeaker.addGestureRecognizer(gestureAudio)
        
        let gestureButton = UITapGestureRecognizer(target: self, action:  #selector(onClickSearchButton(_:)))
        customView.newSearchButton.addGestureRecognizer(gestureButton)
    }
    
    private func finishAudioLoading() {
        self.customView.buttonSpeaker.setLoading(false)
    }
}

//MARK: - SearchResultViewController Delegate

extension DMSearchResultViewController: DMSearchResultViewControllerDelegate {
    func didAudioFailed(errorTitle: String, errorMessage: String) {
        self.finishAudioLoading()
        self.showAlertMessage(title: errorTitle, message: errorMessage)
    }
    
    func didAudioPlayed() {
        self.finishAudioLoading()
    }
}
