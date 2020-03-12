//
//  UIColor+Utils.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 05/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
import UIKit

enum AssetsColor: String {
    case main
}

extension UIColor {
    
    /// Returns a given AssetsColor
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
//    /// Takes an Hexadecimal String value and converts to UIColor
//    convenience init(hexString: String) {
//        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else {
//            self.init()
//            return
//        }
//
//        let a, r, g, b: Int32
//        switch hex.count {
//            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
//            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
//            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
//            default:    (a, r, g, b) = (255, 0, 0, 0)
//        }
//
//        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
//    }
}
