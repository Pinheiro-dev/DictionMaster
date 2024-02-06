//
//  DMSearchViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import UIKit

final class DMSearchViewController: UIViewController {

    private let customView = DMSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        addConstraints()
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
    
}
