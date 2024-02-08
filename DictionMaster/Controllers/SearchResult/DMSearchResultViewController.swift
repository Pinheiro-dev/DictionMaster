//
//  DMSearchResultViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

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
        
//        viewModel.setDelegate(self)
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
        customView.tableView.delegate = (self.viewModel.getInstance() as! any UITableViewDelegate)
        customView.tableView.dataSource = (self.viewModel.getInstance() as! any UITableViewDataSource)
    }
}
