//
//  ServiceMock.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
@testable import GistViewer

class ServiceMock: GistService {

    ///
    override func getGistList(page: Int = 1) {
        self.delegate?.didReceiveGists([])
    }
}
