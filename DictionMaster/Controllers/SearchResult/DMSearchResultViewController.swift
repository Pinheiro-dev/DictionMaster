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
    func pop()
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
        customView.tableView.delegate = viewModel.getInstance()
        customView.tableView.dataSource = viewModel.getInstance()
    }
}

//MARK: - SearchResultViewController Delegate

extension DMSearchResultViewController: DMSearchResultViewControllerDelegate {
    func pop() {
        navigationController?.pop()
    }
    
    func didAudioFailed(errorTitle: String, errorMessage: String) {
        DispatchQueue.main.async {
            self.showAlertMessage(title: errorTitle, message: errorMessage)
        }
    }
}
