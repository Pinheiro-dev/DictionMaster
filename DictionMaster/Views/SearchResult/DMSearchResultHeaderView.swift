//
//  DMSearchResultHeaderView.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 08/02/24.
//

import Foundation
import UIKit

final class DMSearchResultHeaderView: UITableViewHeaderFooterView {
    static let identifier = "DMSearchResultHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Education"
        label.textColor = .init(hexString: "#052D39")
        label.font = .SFProRounded(.bold, size: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pronunciationLabel: UILabel = {
        let label = UILabel()
        label.text = "/ˌedʒuˈkeɪʃn/"
        label.textColor = .init(hexString: "#052D39").withAlphaComponent(0.40)
        label.font = .SFProRounded(.bold, size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let audioView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hexString: "#5BD6FD")
        view.roundCorners(radius: 23)
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let speakerImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "audioSpeaker")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubviews(titleLabel,
                    audioView,
                    pronunciationLabel)
        
        audioView.addSubview(speakerImageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            audioView.heightAnchor.constraint(equalToConstant: 46),
            audioView.widthAnchor.constraint(equalToConstant: 46),
            audioView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            audioView.leftAnchor.constraint(equalTo: leftAnchor),
            audioView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 25),
            
            speakerImageView.heightAnchor.constraint(equalToConstant: 20.4),
            speakerImageView.widthAnchor.constraint(equalToConstant: 22.95),
            speakerImageView.topAnchor.constraint(equalTo: audioView.topAnchor, constant: 12.8),
            speakerImageView.leftAnchor.constraint(equalTo: audioView.leftAnchor, constant: 11.53),
            speakerImageView.rightAnchor.constraint(equalTo: audioView.rightAnchor, constant: -11.53),
            speakerImageView.bottomAnchor.constraint(equalTo: audioView.bottomAnchor, constant: -12.8),
            
            pronunciationLabel.leftAnchor.constraint(equalTo: audioView.rightAnchor, constant: 10),
            pronunciationLabel.rightAnchor.constraint(equalTo: rightAnchor),
            pronunciationLabel.centerYAnchor.constraint(equalTo: audioView.centerYAnchor)
        ])
    }
}
