//
//  FavoriteViewController.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 05/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Variables
    /// The controller's view, instance of MainView
    private unowned var _view:MainView { return self.view as! MainView }
    
    ///
    private var items: [GistItem] = [] {
        didSet {
            _view.tableView.reloadData()
        }
    }
    
    // The presente responsible for the logic of this ViewController
    private let presenter: FavoritePresenter = FavoritePresenter(Storage())
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadFavorites()
    }
    
    // MARK: - Setup
    /// Initial configuration of the view
    private func setupView(){
        _view.tableView.delegate   = self
        _view.tableView.dataSource = self
        _view.tableView.refreshControl =  nil
        presenter.attach(to: self)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource, GistItemDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectGist(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(indexPath, GistItemCell.self)
        let item = items[indexPath.row]
        cell.item = item
        cell.delegate = self
        return cell
    }
    
    func didTapFavorite(_ gistItem: GistItem) {
        presenter.favorite(gistItem)
    }
}

extension FavoriteViewController: MainViewDelegate {
    
    func showFeedback(message: String) {
        _view.tableView.setEmptyView(title: "Ops!", message: message)
    }

    func updateGistList() {
        _view.tableView.reloadData()
    }

    func reloadGistList(_ items: [GistItem]) {
        self.items = items
    }
    
    func goToGistDetails(_ gist:Gist) {
        let nextViewController = DetailViewController()
        nextViewController.setup(with: gist)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

