//
//  DMPill.swift
//  MatheusPinheiroBarbosa
//
//  Created by Fernanda  on 06/02/24.
//

import UIKit

final class DMPill: UIView {
    
    private let viewPill: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#91A9B1").withAlphaComponent(0.10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "englandFlag")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "ENGLISH"
        label.textColor = UIColor(hexString: "#052D39")
        label.font = UIFont(name: "SF-Pro-Rounded-Regular", size: 18)
        label.addCharacterSpacing(kernValue: 1.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners(radius: 20)
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(viewPill)
        viewPill.addSubview(imageView)
        viewPill.addSubview(label)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            viewPill.heightAnchor.constraint(equalToConstant: 40),
            viewPill.topAnchor.constraint(equalTo: topAnchor),
            viewPill.leftAnchor.constraint(equalTo: leftAnchor),
            viewPill.rightAnchor.constraint(equalTo: rightAnchor),
            viewPill.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 27),
            imageView.widthAnchor.constraint(equalToConstant: 26),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            label.heightAnchor.constraint(equalToConstant: 21),
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
}
