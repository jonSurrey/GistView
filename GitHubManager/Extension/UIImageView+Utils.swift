//
//  UIImageView+Utils.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

extension UIImageView{
    
    /// Loads a given image url to the UImageView
    func load(_ url:String?){
        self.image = nil
        guard let string = url, let link = URL(string: string) else {
            return
        }
        self.af_setImage(withURL: link)
    }
}
