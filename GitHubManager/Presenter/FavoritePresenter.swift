//
//  FavoritePresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

// MARK: - FavoriteDelegate
protocol FavoriteDelegate {
    
    /// Checks if the given GistItem should be favorited or not
    func favorite(_ item: GistItem)
}

// MARK: - FavoritePresenter
class FavoritePresenter: MainPresenterDelegate {
    
    /// The list of gists to be used as datasource. It should be private but we make it public for testing purposes
    var gists:[Gist] = []
    
    /// Manager for the  storage
    private var storage: StorageDelegate
    
    /// Instance of the view so we can update it
    private weak var view: MainViewDelegate?
    
    init(_ storage: StorageDelegate) {
        self.storage = storage
    }
    
    /// Binds a view  to this presenter
    func attach(to view: MainViewDelegate) {
        self.view = view
    }
    
    func selectGist(at position: Int) {
        let gist = gists[position]
        view?.goToGistDetails(gist)
    }
    
    func loadFavorites() {
        gists = storage.loadFavorites()
        let items = gists.map { GistItem($0, isFavorite: true) }
        view?.reloadGistList(items)
        if items.isEmpty {
            view?.showFeedback(message: "You have no favorites yet")
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
        view?.updateGistList()
    }
}
