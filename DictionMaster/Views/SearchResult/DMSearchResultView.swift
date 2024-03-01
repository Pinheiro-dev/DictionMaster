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
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DMSearchResultTableViewCell.self,
                       forCellReuseIdentifier: DMSearchResultTableViewCell.cellIdentifier)
        table.register(DMSearchResultHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: DMSearchResultHeaderView.identifier)
        table.register(DMSearchResultFooterView.self,
                       forHeaderFooterViewReuseIdentifier: DMSearchResultFooterView.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
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
        addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
