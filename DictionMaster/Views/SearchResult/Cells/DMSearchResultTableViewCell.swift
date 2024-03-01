//
//  DMSearchResultTableViewCell.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus  on 29/02/24.
//

import Foundation
import UIKit

final class DMSearchResultTableViewCell: UITableViewCell {
    static let cellIdentifier = "DMSearchResultTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.primaryColor
        label.numberOfLines = 0
        label.font = .SFProRounded(.bold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let examplesLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.primaryColor
        label.numberOfLines = 0
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        setUpViews()
        addConstrints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(definitionLabel, examplesLabel)
    }

    private func addConstrints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.5),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -43.5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            definitionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            definitionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            examplesLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 5),
            examplesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            examplesLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            examplesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.definitionLabel.attributedText = nil
        self.examplesLabel.text = nil
    }
}
