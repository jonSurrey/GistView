//
//  ServiceMock.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
import Alamofire
@testable import GistViewer

class ProviderMock: ProviderDelegate {
    var path: String = ""
    var headers: HTTPHeaders?
    var parameters: Parameters?
}

class ServiceMock: GistService {
    
    private var result: [Gist]
    
    init(result: [Gist]) {
        self.result = result
        super.init(ProviderMock())
    }
    
    override func getGistList(page: Int = 1) {
        self.delegate?.didReceiveGists(result)
    }
}
