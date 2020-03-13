//
//  MainViewTests.swift
//  GitHubManagerTests
//
//  Created by Jonathan Martins on 12/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import GistViewer

class MainViewTests: XCTestCase {

    var sut: MainViewMock!
    var service: ServiceMock!
    var storage: StorageDelegate!
    var presenter: MainPresenter!
    
    override func setUp() {
        configure(favorites: [Gist(id: "3"), Gist(id: "4")], result: [Gist(id: "300"), Gist(id: "400")])
    }
    
    private func configure(favorites: [Gist], result: [Gist]) {
        sut = MainViewMock()
        service = ServiceMock(result: result)
        storage = StorageMock(favorites: favorites)
        presenter = MainPresenter(storage)
        presenter.attach(to: sut, service)
    }
    
    func testShowLoadingWasCalled(){
        presenter.getGists()
        XCTAssertTrue(sut.didCallShowLoading, "The func ``showLoading()`` was not called")
    }
    
    func testHideLoadingWasCalled(){
        presenter.getGists()
        XCTAssertTrue(sut.didCallHideLoading, "The func ``hideLoading()`` was not called")
     }
    
    func testShowFeedbackWasCalled(){
        configure(favorites: [], result: [])
        presenter.getGists()
        XCTAssertTrue(sut.didCallShowFeedback, "The func ``showFeedback()`` was not called")
     }
    
    func testReloadGistListWasCalled(){
        presenter.getGists()
        XCTAssertTrue(sut.didCallReloadGistList, "The func ``reloadGistList()`` was not called")
     }
    
    func testUpdateGistListWasCalled(){
        let item = GistItem(Gist())
        presenter.favorite(item)
        XCTAssertTrue(sut.didCallUpdateGistList, "The func ``updateGistList()`` was not called")
     }
    
    func testGoToGistDetailsWasCalled(){
        presenter.getGists()
        presenter.selectGist(at: 1)
        XCTAssertTrue(sut.didCallGoToGistDetails, "The func ``goToGistDetails`` was not called")
     }
}
