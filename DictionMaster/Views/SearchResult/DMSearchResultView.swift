//
//  DMSearchResultView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

final class DMSearchResultView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = Color().primaryColor
        label.font = .SFProRounded(.bold, size: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let pronunciationLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = Color().primaryColor.withAlphaComponent(0.40)
        label.font = .SFProRounded(.bold, size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let buttonSpeaker: DMAudioButton = {
        let view = DMAudioButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DMSearchResultTableViewCell.self,
                       forCellReuseIdentifier: DMSearchResultTableViewCell.cellIdentifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color().primaryColor.withAlphaComponent(0.10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleBottomLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Color().primaryColor
        label.font = .SFProRounded(.bold, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptioBottomLabel: UILabel = {
        let label = UILabel()
        label.text = Localized().searchResult.tryAnotherSearch
        label.textColor = Color().primaryColor
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newSearchButton: DMButton = {
        let button = DMButton(title: Localized().searchResult.newSearch)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubviews(titleLabel,
                    buttonSpeaker,
                    pronunciationLabel,
                    tableView,
                    separatorView,
                    bottomView)
        
        bottomView.addSubviews(titleBottomLabel,
                               descriptioBottomLabel,
                               newSearchButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.5),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -43.5),
            
            buttonSpeaker.heightAnchor.constraint(equalToConstant: 46),
            buttonSpeaker.widthAnchor.constraint(equalToConstant: 46),
            buttonSpeaker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            buttonSpeaker.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.5),
            
            pronunciationLabel.leftAnchor.constraint(equalTo: buttonSpeaker.rightAnchor, constant: 10),
            pronunciationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -43.5),
            pronunciationLabel.centerYAnchor.constraint(equalTo: buttonSpeaker.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: buttonSpeaker.bottomAnchor, constant: 25),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.5),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -43.5),
            tableView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            titleBottomLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 35.5),
            titleBottomLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 20.5),
            titleBottomLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -43.5),
            
            descriptioBottomLabel.topAnchor.constraint(equalTo: titleBottomLabel.bottomAnchor, constant: 8),
            descriptioBottomLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 20.5),
            descriptioBottomLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -43.5),
            
            newSearchButton.heightAnchor.constraint(equalToConstant: 64),
            newSearchButton.topAnchor.constraint(equalTo: descriptioBottomLabel.bottomAnchor, constant: 20),
            newSearchButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 17),
            newSearchButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -16),
            newSearchButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -31),
        ])
    }
}
