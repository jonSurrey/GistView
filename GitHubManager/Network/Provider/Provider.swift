//
//  Provider.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - ProviderDelegate
protocol ProviderDelegate {
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get set }
}

// MARK: - GistsListProvider
class GistsListProvider: ProviderDelegate {
    var path: String = "gists/public"
    var headers: HTTPHeaders?
    var parameters: Parameters? = ["page": 0]
}
