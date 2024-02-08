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
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        addConstrints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpViews() {
        contentView.addSubviews()
    }

    private func addConstrints() {
        NSLayoutConstraint.activate([
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
