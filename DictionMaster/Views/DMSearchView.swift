//
//  DMSearchView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import UIKit

final class DMSearchView: UIView {
    
    private var pill: DMPill = {
        let pill = DMPill()
        pill.translatesAutoresizingMaskIntoConstraints = false
        return pill
    }()

     let textField: UITextField = {
        let field = UITextField()
        field.textColor = .init(hexString: "#052D39")
        field.tintColor = .clear
        field.font = .SFProRounded(.bold, size: 32)
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        
        let attributedString = NSAttributedString(
            string: "Type a word...",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(hexString: "#052D39").withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.SFProRounded(size: 32)
            ]
        )
        field.attributedPlaceholder = attributedString
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let searchButton: DMButton = {
        let button = DMButton(title: "SEARCH")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - Init
    
    var bottomButtonConstraint = NSLayoutConstraint()

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
        addSubviews(pill, textField, searchButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            pill.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            pill.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: pill.topAnchor, constant: 174),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 38),
            
            searchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            searchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            searchButton.heightAnchor.constraint(equalToConstant: 64),
        ])
        bottomButtonConstraint = searchButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomButtonConstraint.isActive = true
    }
}
