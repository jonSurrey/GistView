//
//  DetailView.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class DetailView: UIView {
    
    // The user's image
    let userImage: UIImageView = {
         let imageView = UIImageView()
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleToFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     // The user's name
    let userName: UILabel = {
         let label = UILabel()
         label.numberOfLines = 2
         label.textColor = .black
         label.textAlignment = .left
         label.font = .systemFont(ofSize: 24, weight: .bold)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    // The user's name
    let gistType: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The feedback to be displayed when no content is shown or loading the content
    private let filesTextLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Files"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
extension DetailView{
    
    /// Adds the subviews to the parent
    private func addViews(){
        self.addSubview(gistType)
        self.addSubview(userName)
        self.addSubview(userImage)
        self.addSubview(filesTextLabel)
        self.backgroundColor = .white
    }
    
    /// Sets up the subviews' constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100),
            userImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            userImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            userName.topAnchor.constraint(equalTo: userImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 15),
            userName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            filesTextLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15),
            filesTextLabel.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            filesTextLabel.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            
            gistType.topAnchor.constraint(equalTo: filesTextLabel.bottomAnchor, constant: 5),
            gistType.leadingAnchor.constraint(equalTo: filesTextLabel.leadingAnchor),
            gistType.trailingAnchor.constraint(equalTo: filesTextLabel.trailingAnchor)
        ])
    }
    
    /// Constrols the visibility of the feedback
    func formattFiles(_ files:[String : GistFile]?){
        if let files = files?.compactMap({ $0.value }) {
            let content = files.compactMap({
                "\($0.filename ?? "")\n- \($0.type ?? "")"
            })
            gistType.text = content.joined(separator: "\n\n")
        }
    }
}
