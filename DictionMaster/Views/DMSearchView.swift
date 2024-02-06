//
//  DMSearchView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import UIKit

final class DMSearchView: UIView {
    
    private lazy var pill: DMPill = {
        let pill = DMPill()
        pill.translatesAutoresizingMaskIntoConstraints = false
        return pill
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(pill)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            pill.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            pill.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}


