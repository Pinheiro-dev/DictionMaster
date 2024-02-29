//
//  DMPurchaseViewController.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation
import UIKit

final class DMPurchaseViewController: UIViewController {
    private let customView = DMPurchaseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
        addConstraints()
        bind()
    }
    
    @objc private func onClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(onClick(_:)))
        customView.subscribeButton.addGestureRecognizer(gesture)
    }
}
