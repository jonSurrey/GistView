//
//  DetailViewController.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

// MARK: - DetailViewDelegate
protocol DetailViewDelegate:class {
    
    /// Sets the user name
    func displayUserName(_ name: String?)
    
    /// Sets the user image
    func displayUserImage(_ image: String?)
    
    /// Sets the user's files description
    func displayFiles(_ String: String?)
}

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    /// The controller's view, instance of DatailView
    private unowned var _view: DetailView { return self.view as! DetailView }
    
    // The presente responsible for the logic of this ViewController
    private let presenter: DetailPresenter = DetailPresenter()
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
    }
    
    // MARK: - Setup
    /// Initial configuration of the view
    func setup(with gist: Gist) {
        presenter.attach(to: self, gist)
        presenter.getGistData()
    }
}

// MARK: - DetailView implementation
extension DetailViewController: DetailViewDelegate {
    
    func displayUserName(_ name: String?) {
        _view.userName.text = name
    }
    
    func displayUserImage(_ image: String?) {
        _view.userImage.load(image)
    }
    
    func displayFiles(_ files: String?) {
        _view.gistType.text = files
    }
}
