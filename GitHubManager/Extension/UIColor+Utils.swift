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
}
