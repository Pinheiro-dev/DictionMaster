//
//  DMSearchView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import UIKit

final class DMSearchView: UIView {
    private let pill: DMPill = {
        let pill = DMPill()
        pill.translatesAutoresizingMaskIntoConstraints = false
        return pill
    }()

     let textField: UITextField = {
         let field = UITextField()
         field.textColor = Color.primaryColor
         field.tintColor = .clear
         field.font = .SFProRounded(.bold, size: 32)
         field.textAlignment = .center
         field.autocorrectionType = .no
         field.spellCheckingType = .no
         
         let attributedString = NSAttributedString(
            string: Localized.SearchString.typeAWord,
            attributes: [
                NSAttributedString.Key.foregroundColor: Color.primaryColor.withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.SFProRounded(size: 32)
            ]
        )
        field.attributedPlaceholder = attributedString
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let searchButton: DMButton = {
        let button = DMButton(title: Localized.SearchString.search)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var bottomButtonConstraint = NSLayoutConstraint()
    
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
        addSubviews(pill, textField, searchButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            pill.topAnchor.constraint(equalTo: topAnchor, constant: 75),
            pill.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: pill.bottomAnchor, constant: 181),
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
