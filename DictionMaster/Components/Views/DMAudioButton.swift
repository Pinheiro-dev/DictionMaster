//
//  DMAudioButton.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus  on 28/02/24.
//

import Foundation
import UIKit

final class DMAudioButton: UIView {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let speakerImageView: UIImageView = {
        let imageView = UIImageView()
        let image = Image.speaker
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        config()
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        roundCorners(radius: 23)
        backgroundColor = Color.secondayColor
        isUserInteractionEnabled = true
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        addSubviews(spinner, speakerImageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            speakerImageView.heightAnchor.constraint(equalToConstant: 20.4),
            speakerImageView.widthAnchor.constraint(equalToConstant: 22.95),
            speakerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            speakerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            spinner.heightAnchor.constraint(equalToConstant: 20),
            spinner.widthAnchor.constraint(equalToConstant: 20),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
        
    public func setLoading(_ value: Bool) {
        if value {
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = false
                self.speakerImageView.isHidden = true
                self.spinner.startAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = true
                self.speakerImageView.isHidden = false
                self.spinner.stopAnimating()
            }
        }
    }
}
