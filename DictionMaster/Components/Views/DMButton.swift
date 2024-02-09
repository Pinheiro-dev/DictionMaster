//
//  DMButton.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 07/02/24.
//

import Foundation
import UIKit

final class DMButton: UIButton {
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.configButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButton() {
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .SFProRounded(.bold, size: 18)
        self.titleLabel?.addCharacterSpacing(kernValue: 1.8)
        self.backgroundColor = .init(hexString: "#5BD6FD")
        self.roundCorners(radius: 14)
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func enable(_ value: Bool) {
        if value {
            self.isEnabled = true
            self.alpha = 1
        } else {
            self.isEnabled = false
            self.alpha = 0.5
        }
    }
}

