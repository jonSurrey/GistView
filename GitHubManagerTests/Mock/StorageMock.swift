//
//  StorageMock.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation
@testable import GistViewer

class StorageMock: StorageDelegate {
    
    private var cache:[Gist]     = []
    private var favorites:[Gist] = []
    
    init() { }
    
    init(cache: [Gist]) {
        self.cache = cache
    }
    
    init(favorites: [Gist]) {
        self.favorites = favorites
    }
    
    func clearCache() {
        cache = []
    }
    
    func loadCache() -> [Gist] {
        return cache
    }
    
    func addToCache(_ gist: [Gist]) {
        cache.append(contentsOf: gist)
    }

    func loadFavorites() -> [Gist] {
        return favorites
    }

    func addToFavorite(_ gist: Gist) {
        favorites.append(gist)
    }

    func removeFromFavorite(_ gist: Gist) {
        favorites.removeAll(where: {
            $0.id == gist.id
        })
    }
    
    func isGistFavorite(_ gist: Gist) -> Bool {
        let isFavorite = favorites.first(where: { $0.id == gist.id })
        return isFavorite != nil ? true : false
    }
}
