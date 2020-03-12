//
//  MainViewMock.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
@testable import GistViewer

class MainViewMock: MainViewDelegate {
    
    var didCallShowLoading = false
    var didCallHideLoading = false
    var didCallShowFeedback = false
    var didCallReloadGistList = false
    var didCallUpdateGistList = false
    var didCallGoToGistDetails = false
    
    func showLoading() {
        didCallShowLoading = true
    }
    
    func hideLoading() {
        didCallHideLoading = true
    }
    
    func showFeedback(message: String) {
        didCallShowFeedback = true
    }
    
    func reloadGistList(_ items: [GistItem]) {
        didCallReloadGistList = true
    }
    
    func updateGistList() {
        didCallUpdateGistList = true
    }
    
    func goToGistDetails(_ gist: Gist) {
        didCallGoToGistDetails = true
    }
}
