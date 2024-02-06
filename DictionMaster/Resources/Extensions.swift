//
//  Extensions.swift
//  MatheusPinheiroBarbosa
//
//  Created by Matheus on 06/02/24.
//

import Foundation
import UIKit

//MARK: - View

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }

    func roundCorners(_ corners: [UIRectCorner] = [.allCorners], radius: CGFloat) {
        var maskedCorners: CACornerMask = .init()
        corners.forEach({ corner in
            switch corner {
                case .topLeft:
                    maskedCorners.insert(.layerMinXMinYCorner)
                case .topRight:
                    maskedCorners.insert(.layerMaxXMinYCorner)
                case .bottomLeft:
                    maskedCorners.insert(.layerMinXMaxYCorner)
                case .bottomRight:
                    maskedCorners.insert(.layerMaxXMaxYCorner)
                default:
                    break
            }
        })

        self.layer.cornerRadius = radius
        if !maskedCorners.isEmpty {
            self.layer.maskedCorners = maskedCorners
        }
    }
}

//MARK: - Color

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
