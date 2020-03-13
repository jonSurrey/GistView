//
//  MainPresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

// MARK: - MainPresenterDelegate
protocol MainPresenterDelegate: FavoriteDelegate {
    
    /// Performs the request to retrieve the list of gists
    func getGists(page:Int)
    
    /// Increments the page to request the next results of gits
    func getListNextPage()
    
    /// Selects a gist at the given position of the list
    func selectGist(at position:Int)
    
    /// Load the list of favorited gists
    func loadFavorites()
}

// MARK: - MainPresenterDelegate
/// Default implementation of functions in the MainPresenterDelegate so their implementation are not obligated
extension MainPresenterDelegate {
    func getGists(page:Int) { }
    func getListNextPage() { }
    func loadFavorites() { }
}

// MARK: - MainPresenter
class MainPresenter: MainPresenterDelegate {
    
    /// The list of gists to be used as datasource. It should be private but we make it public for testing purposes
    var gists:[Gist] = []
    
    /// Instance of the view so we can update it
    private weak var view: MainViewDelegate?
    
    /// The service responsible for the requests
    private var service: GistService? {
        didSet {
            service?.delegate = self
        }
    }
    
    /// Manager for the  storage
    private var storage: StorageDelegate
    
    /// The current index of the results of the requests
    private var page: Int = 1 {
        didSet {
            service?.getGistList(page: page)
        }
    }
    
    init(_ storage: StorageDelegate) {
        self.storage = storage
    }
    
    /// Binds a view and a service the to this presenter
    func attach(to view: MainViewDelegate, _ service:GistService) {
        self.view = view
        self.service = service
    }
    
    func getGists(page: Int = 1) {
        view?.showLoading()
        self.page = page
    }
    
    func getListNextPage() {
        getGists(page: page + 1)
        print("Loading more gist from page \(page)...")
    }
    
    func selectGist(at position: Int) {
        let gist = gists[position]
        view?.goToGistDetails(gist)
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

// MARK: - MainPresenter
extension MainPresenter: GistServiceDelegate {
    
    func didReceiveGists(_ gists: [Gist]) {
        view?.hideLoading()
        view?.reloadGistList(formatArrayBeforeDisplay(gists))
    }
    
    func onRequestError(_ error: String) {
        view?.hideLoading()
        if page == 1 {
            view?.reloadGistList([])
            view?.showFeedback(message: error)
        }
    }
    
    func noInternetConection() {
        if page == 1{
            gists = storage.loadCache()
            if gists.isEmpty {
                view?.showFeedback(message: "It seems you are not connected to the internet")
            }
            view?.reloadGistList(formatArrayBeforeDisplay(gists))
        }
        view?.hideLoading()
    }
    
    /// Converts a given [Gist] to [GistItem]
    private func formatArrayBeforeDisplay(_ result: [Gist]) -> [GistItem] {
        if page == 1 {
            storage.addToCache(result)
            gists = result
            if gists.isEmpty {
                view?.showFeedback(message: "Ops... Something went wrong. Please, try again.")
                return []
            }
        } else {
           gists.append(contentsOf: result)
        }
        let items = gists.map { GistItem($0) }
        items.forEach {
            $0.isFavorite = storage.isGistFavorite($0.gist) ? true : false
        }
        return items
    }
}
