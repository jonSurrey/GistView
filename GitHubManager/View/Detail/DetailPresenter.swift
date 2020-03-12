//
//  DetailPresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate {
    
}

class DetailPresenter: DetailPresenterDelegate {
    
    ///
    private weak var viewController: DetailViewDelegate?
    
    ///
    private var gist: Gist?
    
    func attach(to viewController: DetailViewDelegate, _ gist: Gist) {
        self.gist = gist
        self.viewController = viewController
    }
}
