//
//  DetailViewController.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

protocol DetailViewDelegate:class {
    
}

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    /// The controller's view, instance of DatailView
    private unowned var _view:DetailView { return self.view as! DetailView }
    
    ///
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
        
        _view.userName.text = gist.owner?.login
        _view.userImage.load(gist.owner?.photo)
        _view.formattFiles(gist.files)
    }
}

extension DetailViewController: DetailViewDelegate {
    
}
