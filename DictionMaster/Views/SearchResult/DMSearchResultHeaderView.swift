//
//  DMSearchResultHeaderView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 29/02/24.
//

import Foundation
import UIKit

protocol DMSerachResultFooterViewDelegate: AnyObject {
    func stopLoading()
}

final class DMSearchResultHeaderView: UITableViewHeaderFooterView {
    static let identifier = "DMSearchResultHeaderView"

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private weak var delegate: DMSearchResultHeaderFooterDelegate?
    var viewModel: DMSearchResultViewModelDelegate?
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        addConstraints()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(onClick(_:)))
        buttonSpeaker.addGestureRecognizer(gesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onClick(_ sender: UIButton) {
        buttonSpeaker.setLoading(true)
        delegate?.didClick(with: .header)
    }

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(titleLabel,
                                  buttonSpeaker,
                                  pronunciationLabel)
    }

    private func addConstraints() {
         NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.5),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -43.5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 54),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),

            buttonSpeaker.heightAnchor.constraint(equalToConstant: 46),
            buttonSpeaker.widthAnchor.constraint(equalToConstant: 46),
            buttonSpeaker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            buttonSpeaker.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            buttonSpeaker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25),
            
            pronunciationLabel.leftAnchor.constraint(equalTo: buttonSpeaker.rightAnchor, constant: 11),
            pronunciationLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            pronunciationLabel.centerYAnchor.constraint(equalTo: buttonSpeaker.centerYAnchor),
        ])        
    }
    
    public func setDelegate(delegate: DMSearchResultHeaderFooterDelegate) {
        self.delegate = delegate
    }
    
    public func configViewModel(with viewModel: DMSearchResultViewModel) {
        self.viewModel = viewModel
        self.viewModel?.setHeaderDelegate(self)
    }
}

//MARK: - SearchResultHeaderVide Delegate

extension DMSearchResultHeaderView: DMSerachResultFooterViewDelegate {
    func stopLoading() {
        DispatchQueue.main.async {
            self.buttonSpeaker.setLoading(false)
        }
    }
}
