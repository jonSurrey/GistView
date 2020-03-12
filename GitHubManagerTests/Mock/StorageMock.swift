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
    
    func clearCache() {
        
    }
    
    func loadCache() -> [Gist] {
        
    }
    
    func addToCache(_ gist: [Gist]) {
        
    }
    
    func loadFavorites() -> [Gist] {
        
    }
    
    func addToFavorite(_ gist: Gist) {
        
    }
    
    func removeFromFavorite(_ gist: Gist) {
        
    }
    
    func isGistFavorite(_ gist: Gist) -> Bool {
        
    }
}
