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
    var service: ServiceMock!
    var storage: StorageDelegate!
    var presenter: MainPresenter!
    
    override func setUp() {
        view      = MainViewMock()
        service   = ServiceMock()
        storage   = StorageMock()
        presenter = FavoritePresenter(storage)
        
        presenter.attach(to: view, service)
    }
    
    func testGetGists(){
        presenter.getGists()
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
    
    func testGetNextPageOfItems(){
        presenter.getGists(page: 2)
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
    
    func testSelectGistFromItems(){
        presenter.selectGist(at: 2)
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
    
    func testLoadFavoriteGists(){
        presenter.loadFavorites()
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
    
    func testAddGistToFavorite(){
        presenter.favorite()
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
    
    func testRemoveGistFromFavorite(){
        presenter.favorite()
        XCTAssertFalse(presenter.gists.isEmpty, "The list of movies should not be empty after the request")
    }
}
