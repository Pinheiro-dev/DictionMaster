//
//  DMButton.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation
import UIKit

final class DMButton: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.textColor = .white
        label.font = .SFProRounded(.bold, size: 18)
        label.addCharacterSpacing(kernValue: 1.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let title: String
    
    //MARK: - Init
    init(title: String) {
        self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.config()
        self.setupViews()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        roundCorners(radius: 14)
        backgroundColor = Color.secondayColor
        isUserInteractionEnabled = true
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        self.addSubviews(spinner, titleLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            spinner.heightAnchor.constraint(equalToConstant: 21),
            spinner.widthAnchor.constraint(equalToConstant: 21),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
        
    public func setLoading(_ value: Bool) {
        if value {
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = true
                self.titleLabel.isHidden = false
                self.spinner.stopAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = false
                self.titleLabel.isHidden = true
                self.spinner.startAnimating()
            }
        }
    }
}
