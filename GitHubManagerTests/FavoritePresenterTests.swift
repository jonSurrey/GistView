//
//  FavoritePresenterTests.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import GistViewer

class FavoritePresenterTests: XCTestCase {

    var view: MainViewDelegate!
    var storage: StorageDelegate!
    var sut: FavoritePresenter!
    
    override func setUp() {
        configure(with: [Gist(id: "1"), Gist(id: "2")])
    }
    
    private func configure(with items: [Gist]) {
        view = MainViewMock()
        storage = StorageMock(favorites: items)
        sut = FavoritePresenter(storage)
        sut.attach(to: view)
    }
    
    func testLoadFavoriteGists(){
        sut.loadFavorites()
        XCTAssertFalse(sut.gists.isEmpty, "The list of gists should not be empty after loading the favorites")
    }
    
    func testLoadFavoriteGistsIsEmpty(){
        configure(with: [])
        sut.loadFavorites()
        XCTAssertTrue(sut.gists.isEmpty, "The list of gists should be empty after loading the favorites")
    }
    
    func testAddGistToFavorite(){
        let item = GistItem(Gist(id: "10"))
        sut.favorite(item)
        sut.loadFavorites()
        
        let result = sut.gists.contains(where: { $0.id == "10" })
        
        XCTAssertTrue(result, "The gist item with id ``10`` should be in the gist list, but it is not")
    }
    
    func testRemoveGistFromFavorite(){
        let item = GistItem(Gist(id: "2"))
        sut.favorite(item)
        sut.loadFavorites()
        
        let result = sut.gists.contains(where: { $0.id == "2" })
        
        XCTAssertFalse(result, "The gist item with id ``2`` should not be in the gist list, but it is")
    }
}
