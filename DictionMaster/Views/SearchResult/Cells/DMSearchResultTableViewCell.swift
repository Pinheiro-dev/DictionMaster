//
//  DMSearchResultTableViewCell.swift
//  MatheusPinheiroBarbosa
//
//  Created by Fernanda  on 08/02/24.
//

import Foundation
import UIKit

final class DMSearchResultTableViewCell: UITableViewCell {
    static let cellIdentifier = "DMSearchResultTableViewCell"
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = "1) [uncountable, countable] a process of teaching, training and learning, especially in schools, colleges or universities, to improve knowledge and develop skills"
        label.textColor = UIColor(hexString: "#052D39")
        label.numberOfLines = 0
        label.font = .SFProRounded(.bold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let examplesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#052D39")
        label.numberOfLines = 0
        label.font = .SFProRounded(size: 16)
        label.text = """
                     • primary/elementary education
                     • post-secondary education
                     • a college/university education
                     • She completed her formal education in 2019.
                     • Students from lower income families are less
                     • likely to continue their education.
                     • to further/pursue your education
                     • to get/receive an education
                     • The school provides an excellent all-round
                    """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
        addConstrints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpViews() {
        contentView.addSubviews(definitionLabel, examplesLabel)
    }

    private func addConstrints() {
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            definitionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            definitionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            examplesLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 5),
            examplesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            examplesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            examplesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.definitionLabel.text = nil
        self.examplesLabel.text = nil
    }
}
