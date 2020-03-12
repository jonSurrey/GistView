//
//  StorageTests.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins De Oliveira on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import XCTest

class StorageTests: XCTestCase {

    var storage: StorageDelegate!
    
    func testLoadEmptyCachedGistsList(){
        storage = StorageMock()
        let cache = storage.loadCache()
        XCTAssertTrue(cache.isEmpty, "The cached gists list should be empty")
    }
    
    func testLoadCachedGistsList(){
        storage = StorageMock()
        let cache = storage.loadCache()
        XCTAssertFalse(cache.isEmpty, "The cached movies list should NOT be empty")
    }
    
    func testClearCachedGists(){
        storage = StorageMock()
        storage.clearCache()
        
        /// Expected result
        let result = storage.loadCache()
        XCTAssertTrue(result.isEmpty, "The cached movies list should be empty after calling the clear function")
    }
    
    func testLoadFavoriteGists(){
        storage = StorageMock()
        let result = storage.loadFavorites()
        XCTAssertEqual(result.count, 2, "The favorite list should have 2 items")
    }
    
    func testAddGistToFavorites(){
        storage = StorageMock()
        let gist = Gist()
        storage.addToFavorite(gist)
        
        let result = storage.loadFavorites()
        XCTAssertEqual(result.count, 3, "The favorite list should have 3 items")
    }
    
    func testRemoveGistFromFavorites(){
        storage = StorageMock()
        let gist = Gist()
        storage.removeFromFavorite(gist)
        
        let result = storage.loadFavorites()
        XCTAssertEqual(result.count, 1, "The favorite list should have 3 items")
    }
    
    func testCheckGistIsFavorite(){
        let gist  = Gist()
        let result = storage.isGistFavorite(gist)
        
        XCTAssertTrue(result, "The given gist should be a favorite")
    }
    
    func testCheckGistIsNotFavorite(){
        let gist  = Gist()
        let result = storage.isGistFavorite(gist)
        
        XCTAssertFalse(result, "The given gist should not be a favorite")
    }
}
