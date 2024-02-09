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
        
        viewModel.setDelegate(self)
        setupView()
        addConstraints()
        bind()
    }
    
    @objc private func onClickSearchButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func onClickAudio(_ sender: UIButton) {
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
        customView.titleBottomLabel.text = self.viewModel.titleBottom
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(onClickAudio(_:)))
        customView.audioView.addGestureRecognizer(gesture)
        customView.newSearchButton.addTarget(self, action: #selector(onClickSearchButton(_:)), for: .touchUpInside)
        
        customView.tableView.delegate = (self.viewModel.getInstance() as! any UITableViewDelegate)
        customView.tableView.dataSource = (self.viewModel.getInstance() as! any UITableViewDataSource)
    }
}

extension DMSearchResultViewController: DMSearchResultViewControllerDelegate {
    func didAudioFailed(errorTitle: String, errorMessage: String) {
        self.showAlertMessage(title: errorTitle, message: errorMessage)
    }
}
