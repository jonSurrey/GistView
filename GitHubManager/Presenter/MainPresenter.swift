//
//  MainPresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

protocol MainPresenterDelegate: FavoriteDelegate {
    func getGists(page:Int)
    func getListNextPage()
    func selectGist(at position:Int)
    func loadFavorites()
}

extension MainPresenterDelegate {
    func getGists(page:Int) { }
    func getListNextPage() { }
    func loadFavorites() { }
}

class MainPresenter: MainPresenterDelegate {
    
    ///
    private var gists:[Gist] = []
    
    ///
    private weak var viewController: MainViewDelegate?
    
    ///
    private var service:GistService? {
        didSet {
            service?.delegate = self
        }
    }
    
    /// Manager for the  storage
    private var storage: StorageDelegate
    
    ///
    private var page: Int = 1 {
        didSet {
            service?.getGistList(page: page)
        }
    }
    
    init(_ storage: StorageDelegate) {
        self.storage = storage
    }
    
    func attach(to viewController: MainViewDelegate, _ service:GistService) {
        self.viewController = viewController
        self.service = service
        
    }
    
    func getGists(page: Int = 1) {
        viewController?.showLoading()
        self.page = page
    }
    
    func getListNextPage() {
        getGists(page: page + 1)
        print("Loading more gist from page \(page)...")
    }
    
    func selectGist(at position: Int) {
        let gist = gists[position]
        viewController?.goToGistDetails(gist)
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

extension MainPresenter: GistServiceDelegate {
    
    func didReceiveGists(_ gists: [Gist]) {
        viewController?.hideLoading()
        viewController?.reloadGistList(formatArrayBeforeDisplay(gists))
    }
    
    func onRequestError(_ error: String) {
        viewController?.hideLoading()
        if page == 1 {
            viewController?.reloadGistList([])
            viewController?.showFeedback(message: error)
        }
    }
    
    func noInternetConection() {
        if page == 1{
            gists = storage.loadCache()
            if gists.isEmpty {
                viewController?.showFeedback(message: "It seems you are not connected to the internet")
            }
            viewController?.reloadGistList(formatArrayBeforeDisplay(gists))
        }
        viewController?.hideLoading()
    }
    
    ///
    private func formatArrayBeforeDisplay(_ result: [Gist]) -> [GistItem] {
        if page == 1 {
            storage.addToCache(result)
            gists = result
            if gists.isEmpty {
                viewController?.showFeedback(message: "Ops... Something went wrong. Please, try again.")
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
