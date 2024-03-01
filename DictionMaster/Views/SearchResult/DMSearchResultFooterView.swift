//
//  DMSearchResultFooterView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 29/02/24.
//

import Foundation
import UIKit

final class DMSearchResultFooterView: UITableViewHeaderFooterView {
    static let identifier = "DMSearchResultFooterView"
    private weak var delegate: DMSearchResultHeaderFooterDelegate?

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primaryColor.withAlphaComponent(0.10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptioBottomLabel: UILabel = {
        let label = UILabel()
        label.text = Localized.SearchResultString.tryAnotherSearch
        label.textColor = Color.primaryColor
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleBottomLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Color.primaryColor
        label.font = .SFProRounded(.bold, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newSearchButton: DMButton = {
        let button = DMButton(title: Localized.SearchResultString.newSearch)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        addConstraints()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(onClick(_:)))
        newSearchButton.addGestureRecognizer(gesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onClick(_ sender: UIButton) {
        delegate?.didClick(with: .footer)
    }

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(separatorView,
                                  bottomView,
                                  titleBottomLabel,
                                  descriptioBottomLabel,
                                  newSearchButton)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate(
            [
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                separatorView.topAnchor.constraint(
                    equalTo: containerView.topAnchor,
                    constant: 7
                ),
                separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                separatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                separatorView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
                
                bottomView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                bottomView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                
                titleBottomLabel.topAnchor.constraint(
                    equalTo: bottomView.topAnchor,
                    constant: 35.5
                ),
                titleBottomLabel.leftAnchor.constraint(
                    equalTo: bottomView.leftAnchor,
                    constant: 20.5
                ),
                titleBottomLabel.rightAnchor.constraint(
                    equalTo: bottomView.rightAnchor,
                    constant: -43.5
                ),
                titleBottomLabel.bottomAnchor.constraint(
                    equalTo: descriptioBottomLabel.topAnchor,
                    constant: -8
                ),
                
                
                descriptioBottomLabel.leftAnchor.constraint(
                    equalTo: bottomView.leftAnchor,
                    constant: 20.5
                ),
                descriptioBottomLabel.rightAnchor.constraint(
                    equalTo: bottomView.rightAnchor,
                    constant: -43.5
                ),
                descriptioBottomLabel.bottomAnchor.constraint(
                    equalTo: newSearchButton.topAnchor,
                    constant: -20
                ),
                
                newSearchButton.heightAnchor.constraint(equalToConstant: 64),
                newSearchButton.leftAnchor.constraint(
                    equalTo: bottomView.leftAnchor,
                    constant: 17
                ),
                newSearchButton.rightAnchor.constraint(
                    equalTo: bottomView.rightAnchor,
                    constant: -16
                ),
                newSearchButton.bottomAnchor.constraint(
                    equalTo: bottomView.bottomAnchor,
                    constant: -31
                ),
            ]
        )
    }
    
    public func setDelegate(delegate: DMSearchResultHeaderFooterDelegate){
        self.delegate = delegate
    }
}
