//
//  MainView.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit
import Foundation

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}

class MainView: UIView {
    
    // MARK: - SubViews
    /// The list of the user's
    lazy var tableView:UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView()
        tableview.registerCell(GistItemCell.self)
        tableview.refreshControl = refreshControl
        tableview.rowHeight = UITableView.automaticDimension
        //tableview.setcon contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    /// Indicates if the UITableView is refreshed
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .appColor(.main )
        return refreshControl
    }()
    
    /// The error message to be displayed if the UITableView does not load the content
    let errorMessage:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init's
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension MainView{
    
    /// Adds the subviews to the parent
    private func addViews(){
        self.addSubview(tableView)
        self.addSubview(errorMessage)
        self.backgroundColor = .white
    }
    
    /// Sets up the subviews' constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            errorMessage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            errorMessage.bottomAnchor .constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            errorMessage.widthAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 1/1.3)
        ])
    }
}
