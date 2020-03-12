//
//  UITableView+Utils.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit
import Foundation

extension UITableView{
    
    /// Returns a UITableView for the given Class Type
    func getCell<T:UITableViewCell>(_ indexPath: IndexPath, _ type:T.Type) -> T{
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    /// Register a Cell in the TableView, given an UITableViewCell Type
    func registerCell<T:UITableViewCell>(_ cell:T.Type){
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    /// Shows a message when the TableView is empty
    func setEmptyView(title: String, message: String) {
        
        let titleLabel   = UILabel()
        let messageLabel = UILabel()
        let emptyView    = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))

        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .appColor(.main)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .darkGray
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor .constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.bottomAnchor  .constraint(equalTo: emptyView.centerYAnchor , constant: -50),
            titleLabel.widthAnchor   .constraint(equalTo: emptyView.widthAnchor   , multiplier: 1/1.2),

            messageLabel.topAnchor     .constraint(equalTo: titleLabel.bottomAnchor  , constant: 10),
            messageLabel.leadingAnchor .constraint(equalTo: titleLabel.leadingAnchor , constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -20)
        ])

        self.separatorStyle = .none
        self.backgroundView = emptyView
    }
    
    /// Clears the Tableview backgroundView
    func hideEmptyMessage() {
        self.backgroundView = nil
    }
}
