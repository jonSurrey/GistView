//
//  MainViewController.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 05/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

protocol MainViewDelegate:class {
    
    /// Displays the loading on the view
    func showLoading()
    
    /// Hides the loading on the view
    func hideLoading()
    
    /// Shows  a feedback message
    func showFeedback(message:String)
    
    /// reloads the list of gist
    func reloadGistList(_ items: [GistItem])
    
    /// Updates the list of gist
    func updateGistList()
    
    ///
    func goToGistDetails(_ gist:Gist)
}

extension MainViewDelegate {
    func showLoading() { }
    func hideLoading() { }
}

class MainViewController: UIViewController {
    
    // MARK: - Variables
    /// The controller's view, instance of MainView
    private unowned var _view:MainView { return self.view as! MainView }

    // Controls if the list is loading more items
    private var isLoadingMore = false

    // Controls the Scroll's last position
    private var lastOffset: CGFloat = 0.0

    // Indicates if it's the first time loading the app
    private var firstTime = true
    
    ///
    private var items: [GistItem] = [] {
        didSet {
            _view.tableView.reloadData()
        }
    }
    
    // The presente responsible for the logic of this ViewController
    private let presenter: MainPresenter = MainPresenter(Storage())
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GistViewer"
        setupView()
        setupPresenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }
    
    // MARK: - Setup
    /// Initial configuration of the vieew
    private func setupView(){
        _view.tableView.delegate   = self
        _view.tableView.dataSource = self
        _view.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        
        let favorites = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(goToGistFavorites))
        navigationItem.rightBarButtonItems = [favorites]
    }
    
    func setupPresenter() {
        let provider = GistsListProvider()
        let service  = GistService(provider)
        presenter.attach(to: self, service)
    }
    
    @objc private func refreshData() {
        presenter.getGists()
    }
    
    @objc private func goToGistFavorites() {
        let nextViewController = FavoriteViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, GistItemDelegate {
    
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



// MARK: - ScrollViewDelegate
extension MainViewController{
    
    // Load more items when the collectionView's scrolls reach the bottom
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == _view.tableView && items.count != 0{
            
            let contentOffset = scrollView .contentOffset.y
            let maximumOffset = (scrollView.contentSize.height - scrollView.frame.size.height)
   
            // Checks if it is the end of the scroll
            if(contentOffset >= maximumOffset){
                if(!isLoadingMore){
                    isLoadingMore = true
                    presenter.getListNextPage()
                }
            }
        }
    }
}

extension MainViewController: MainViewDelegate {

    func showLoading() {
        if !_view.refreshControl.isRefreshing {
            _view.refreshControl.beginRefreshingManually()
        }
    }
    
    func hideLoading() {
        if _view.refreshControl.isRefreshing {
            _view.refreshControl.endRefreshing()
        }
    }
    
    func showFeedback(message: String) {
        _view.tableView.setEmptyView(title: "Ops!", message: message)
    }
    
    func updateGistList() {
        _view.tableView.reloadData()
    }

    func reloadGistList(_ items: [GistItem]) {
        isLoadingMore = false
        self.items = items
    }
    
    func goToGistDetails(_ gist:Gist) {
        let nextViewController = DetailViewController()
        nextViewController.setup(with: gist)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

