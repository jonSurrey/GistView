//
//  MainPresenterTests.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import GistViewer

class MainPresenterTests: XCTestCase {
    
    var view: MainViewDelegate!
    var service: ServiceMock!
    var storage: StorageDelegate!
    var sut: MainPresenter!
    
    override func setUp() {
        configure(favorites: [Gist(id: "3"), Gist(id: "4")], result: [Gist(id: "300"), Gist(id: "400")])
    }
    
    private func configure(favorites: [Gist], result: [Gist]) {
        view = MainViewMock()
        service = ServiceMock(result: result)
        storage = StorageMock(favorites: favorites)
        sut = MainPresenter(storage)
        sut.attach(to: view, service)
    }
    
    func testLoadFavoriteGists(){
        sut.loadFavorites()
        XCTAssertFalse(sut.gists.isEmpty, "The list of gists should not be empty after loading the favorites")
    }
    
    func testLoadFavoriteGistsIsEmpty(){
        configure(favorites: [], result: [])
        sut.loadFavorites()
        XCTAssertTrue(sut.gists.isEmpty, "The list of gists should be empty after loading the favorites")
    }
    
    func testAddGistToFavorite(){
        let item = GistItem(Gist(id: "7"))
        sut.favorite(item)
        sut.loadFavorites()
        
        let result = sut.gists.contains(where: { $0.id == "7" })
        
        XCTAssertTrue(result, "The gist item with id ``7`` should be in the gist list, but it is not")
    }
    
    func testRemoveGistFromFavorite(){
        let item = GistItem(Gist(id: "3"))
        sut.favorite(item)
        sut.loadFavorites()
        
        let result = sut.gists.contains(where: { $0.id == "3" })
        
        XCTAssertFalse(result, "The gist item with id `3`` should not be in the gist list, but it is")
    }

    func testGetGists(){
        sut.getGists()
        XCTAssertFalse(sut.gists.isEmpty, "The list of gists should not be empty after the request")
    }
    
    func testGetGistsReturnsEmpty(){
        configure(favorites: [], result: [])
        sut.getGists()
        XCTAssertTrue(sut.gists.isEmpty, "The list of gists should be empty after the request")
    }
}
