//
//  Provider.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
import Alamofire

protocol ProviderDelegate {
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get set }
}

class GistsListProvider: ProviderDelegate {
    var path: String = "gists/public"
    var headers: HTTPHeaders?
    var parameters: Parameters? = ["page": 0]
    
    init() {
       
    }
}

class GistsDetailProvider: ProviderDelegate {
    var path: String
    var headers: HTTPHeaders?
    var parameters: Parameters?
    
    init(_ id:String) {
        path  = "gists/\(id)"
    }
}
