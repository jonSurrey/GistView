//
//  FavoritePresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

protocol FavoriteDelegate {
    func favorite(_ item: GistItem)
}

class FavoritePresenter: MainPresenterDelegate {
    
    ///
    private var gists:[Gist] = []
    
    /// Manager for the  storage
    private var storage: StorageDelegate
    
    ///
    private weak var viewController: MainViewDelegate?
    
    init(_ storage: StorageDelegate) {
        self.storage = storage
    }
    
    func attach(to viewController: MainViewDelegate) {
        self.viewController = viewController
    }
    
    func selectGist(at position: Int) {
        let gist = gists[position]
        viewController?.goToGistDetails(gist)
    }
    
    func loadFavorites() {
        let items = storage.loadFavorites().map { GistItem($0, isFavorite: true) }
        viewController?.reloadGistList(items)
        if items.isEmpty {
            viewController?.showFeedback(message: "You have no favorites yet")
        }
    }
    
    func favorite(_ item: GistItem) {
        let gist = item.gist
        if !storage.isGistFavorite(gist) {
            item.isFavorite = true
            storage.addToFavorite(gist)
        } else {
            item.isFavorite = false
            storage.removeFromFavorite(gist)
        }
        viewController?.updateGistList()
    }
}
