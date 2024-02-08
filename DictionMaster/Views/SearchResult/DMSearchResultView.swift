//
//  DMSearchResultView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

final class DMSearchResultView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DMSearchResultTableViewCell.self,
                       forCellReuseIdentifier: DMSearchResultTableViewCell.cellIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#052D39").withAlphaComponent(0.10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleBottomLabel: UILabel = {
        let label = UILabel()
        label.text = #"That’s it for "education"!"#
        label.font = .SFProRounded(.bold, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptioBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Try another search now!"
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newSearchButton: DMButton = {
        let button = DMButton(title: "NEW SEARCH")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layoutIfNeeded()
        setupViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubviews(tableView,
                    separatorView,
                    bottomView)
        bottomView.addSubviews(titleBottomLabel,
                               descriptioBottomLabel,
                               newSearchButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
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
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
        ])
    }
}
