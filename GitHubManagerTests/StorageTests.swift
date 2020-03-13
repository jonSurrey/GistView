//
//  StorageTests.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins De Oliveira on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import GistViewer

class StorageTests: XCTestCase {

    var sut: StorageDelegate!
    
    override func setUp() {
        sut = StorageMock()
    }
    
    private func setupFavoriteStorage() {
        let gists:[Gist] = [Gist(id: "1"), Gist(id: "2"), Gist(id: "3"), Gist(id: "4"), Gist(id: "5")]
        sut = StorageMock(favorites: gists)
    }
    
    private func setupCacheStorage() {
        let gists:[Gist] = [Gist(id: "1"), Gist(id: "2"), Gist(id: "3"), Gist(id: "4"), Gist(id: "5")]
        sut = StorageMock(cache: gists)
    }
    
    func testLoadEmptyCachedGistsList(){
        let cache = sut.loadCache()
        XCTAssertTrue(cache.isEmpty, "The cached gists list should be empty")
    }
    
    func testLoadCachedGistsList(){
        setupCacheStorage()
        let cache = sut.loadCache()
        XCTAssertFalse(cache.isEmpty, "The cached gists list should NOT be empty")
    }
    
    func testClearCachedGists(){
        setupCacheStorage()
        sut.clearCache()
        
        let result = sut.loadCache()
        XCTAssertTrue(result.isEmpty, "The cached gists list should be empty after calling the clear function")
    }
    
    func testLoadFavoriteGists(){
        setupFavoriteStorage()
        let result = sut.loadFavorites()
        XCTAssertEqual(result.count, 5, "The favorite list should have 5 items")
    }
    
    func testAddGistToFavorites(){
        setupFavoriteStorage()
        
        let gist = Gist(id: "6")
        sut.addToFavorite(gist)
        
        let result = sut.loadFavorites()
        XCTAssertEqual(result.count, 6, "The favorite list should have 6 items")
    }
    
    func testRemoveGistFromFavorites(){
        setupFavoriteStorage()
        
        let gist = Gist(id: "5")
        sut.removeFromFavorite(gist)
        
        let result = sut.loadFavorites()
        XCTAssertEqual(result.count, 4, "The favorite list should have 4 items")
    }
    
    func testCheckGistIsFavorite(){
        setupFavoriteStorage()
        
        let gist = Gist(id: "1")
        let result = sut.isGistFavorite(gist)
        
        XCTAssertTrue(result, "The given gist should be a favorite")
    }
    
    func testCheckGistIsNotFavorite(){
        setupFavoriteStorage()
        
        let gist = Gist(id: "10")
        let result = sut.isGistFavorite(gist)
        XCTAssertFalse(result, "The given gist should not be a favorite")
    }
}
