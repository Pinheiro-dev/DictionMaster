//
//  DMPurchaseView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import UIKit

final class DMPurchaseView: UIView {
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "personPhoto")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "icon")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "title")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#052D39")
        label.font = .SFProRounded(.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullString = "Subscribe now to get unlimited searches and full access to all features."
        label.attributedText = fullString.attributedString(
            subStr: "unlimited", "all features.",
            font: .SFProRounded(.bold, size: 20),
            color: UIColor(hexString: "#5BD6FD")
        )
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#052D39")
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullString = "Try 7 Days Free, then only $19,99 per year. Cancel anytime."
        label.attributedText = fullString.attributedString(
            subStr: "Try 7 Days Free", "$19,99",
            font: .SFProRounded(.bold, size: 16),
            color: UIColor(hexString: "#052D39")
        )
        return label
    }()
    
    let subsbribeButton: DMButton = {
        let button = DMButton(title: "SUBSCRIBE")
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
        addSubviews(personImageView,
                    logoImageView,
                    titleImageView,
                    infoLabel,
                    priceLabel,
                    subsbribeButton)
    }
    
    private func addConstraints() {
        let logoImgHeight: CGFloat = 130 // 78(height XD) + 52(height image shadow)
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: topAnchor),
            personImageView.leftAnchor.constraint(equalTo: leftAnchor),
            personImageView.rightAnchor.constraint(equalTo: rightAnchor),
            personImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 39),
            
            
            logoImageView.heightAnchor.constraint(equalToConstant: logoImgHeight),
            logoImageView.widthAnchor.constraint(equalToConstant: logoImgHeight),
            logoImageView.topAnchor.constraint(equalTo: personImageView.bottomAnchor,
                                               constant: -(logoImgHeight / 2)),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleImageView.heightAnchor.constraint(equalToConstant: 32),
            titleImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -17.85),
            titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoLabel.heightAnchor.constraint(equalToConstant: 79),
            infoLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 26),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -23),
            
            
            priceLabel.heightAnchor.constraint(equalToConstant: 42),
            priceLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 36.7),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -23),
            
            subsbribeButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            subsbribeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            subsbribeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            subsbribeButton.heightAnchor.constraint(equalToConstant: 64),
            subsbribeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
