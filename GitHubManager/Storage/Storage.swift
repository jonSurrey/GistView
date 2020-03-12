//
//  Service.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 11/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit
import Foundation

// MARK: - StorageDelegate
protocol StorageDelegate {
    
    /// Removes all cache
    func clearCache()
    
    /// Loads the cached Gists
    func loadCache() -> [Gist]

    /// Saves a given list of Gists
    func addToCache(_ gist: [Gist])

    /// Loads the Gists that the user has favorited
    func loadFavorites() -> [Gist]

    /// Saves a given Gist favorited by the user
    func addToFavorite(_ gist: Gist)

    /// Deletes a given movie that the user has unfavorited
    func removeFromFavorite(_ gist: Gist)

    /// Checks if a Gist exists in the favorite list
    func isGistFavorite(_ gist:Gist) -> Bool
}

// MARK: - StorageKey
enum StorageKey: String {
    case cache = "GIST_CACHE"
    case favorite = "GIST_FAVORITE"
    
    var value: String {
        return self.rawValue
    }
}

// MARK: - Storage
class Storage: StorageDelegate{
    
    private let defaults = UserDefaults.standard

    func loadCache() -> [Gist] {
        return loadGists(from: .cache)
    }
    
    func addToCache(_ gists: [Gist]) {
        clearCache()
        gists.forEach({ gist in
            save(gist, to: .cache)
        })
    }
    
    func clearCache() {
        defaults.removeObject(forKey: StorageKey.cache.value)
    }
    
    func loadFavorites() -> [Gist] {
        return loadGists(from: .favorite)
    }
    
    func addToFavorite(_ gist: Gist) {
        save(gist, to: .favorite)
    }
    
    func removeFromFavorite(_ gist: Gist) {
        guard let id = gist.id else { return }
        
        var favorites = loadFavorites()
        favorites.removeAll(where: {
            $0.id == id
        })
        encodeArrayToGistJson(favorites, to: .favorite)
    }
    
    func isGistFavorite(_ gist:Gist) -> Bool {
        let favorites = loadFavorites()
        let isFavorite = favorites.first(where: { $0.id == gist.id })
        return isFavorite != nil ? true : false
    }
}

// MARK: - Private Functions
extension Storage{
    
    /// Saves a gist to the given storage key
    private func save(_ gist: Gist, to storageKey: StorageKey) {
        var gists = loadGists(from: storageKey)
        gists.append(gist)
        encodeArrayToGistJson(gists, to: storageKey)
    }
    
    /// Loads the list of gists from UserDefaults
    private func loadGists(from storageKey: StorageKey) -> [Gist] {
        guard let json = defaults.string(forKey: storageKey.value), let data = json.data(using: .utf8) else {
            return []
        }
        return (try? JSONDecoder().decode([Gist].self, from: data)) ?? []
    }
    
    /// Converts a given Array of Gist to json and saves in the UserDefaults
    private func encodeArrayToGistJson(_ gists: [Gist], to storageKey: StorageKey) {
        guard let data = try? JSONEncoder().encode(gists) else { return }
        let json = String(data: data, encoding: .utf8)
        defaults.set(json, forKey: storageKey.value)
    }
}



class StorageMock: StorageDelegate {
    
    private var cache: [Gist]
    private var favorites: [Gist]
    
    init(_ cache: [Gist], _ favorites: [Gist]) {
        self.cache = cache
        self.favorites = favorites
    }
    
    func clearCache() {
        cache = []
    }
    
    func loadCache() -> [Gist] {
        return cache
    }
    
    func addToCache(_ gist:[Gist]) {
        cache = gist
    }

    func loadFavorites() -> [Gist] {
        return favorites
    }

    func addToFavorite(_ gist:Gist) {
        favorites.append(gist)
    }

    func removeFromFavorite(_ gist:Gist) {
        favorites.removeAll(where: {
            $0.id == gist.id
        })
    }
    
    func isGistFavorite(_ gist:Gist) -> Bool {
        let isFavorite = favorites.first(where: { $0.id == gist.id })
        return isFavorite != nil ? true : false
    }
}
