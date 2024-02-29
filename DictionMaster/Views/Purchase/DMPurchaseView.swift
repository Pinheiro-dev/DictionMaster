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
        let image = Image().personPhoto
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = Image().logoIcon
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        let image = Image().titleImg
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
        label.textColor = Color().primaryColor
        label.font = .SFProRounded(.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullString = Localized().purchase.limitExceeded
        label.attributedText = fullString.attributedString(
            subStr: Localized().purchase.unlimited, Localized().purchase.allFeatures,
            font: .SFProRounded(.bold, size: 20),
            color: Color().secondayColor
        )
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Color().primaryColor
        label.font = .SFProRounded(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullString = Localized().purchase.pricePurchaseLabel
        label.attributedText = fullString.attributedString(
            subStr: Localized().purchase.trySevenDays, Localized().purchase.pricePurchaseValue,
            font: .SFProRounded(.bold, size: 16),
            color: Color().primaryColor
        )
        return label
    }()
    
    let subscribeButton: DMButton = {
        let button = DMButton(title: Localized().purchase.subscribe)
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
                    subscribeButton)
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
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -23),
            priceLabel.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -16),
            
            subscribeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            subscribeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            subscribeButton.heightAnchor.constraint(equalToConstant: 64),
            subscribeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -36)
        ])
    }
}
