//
//  GitItemCell.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import UIKit

protocol GistItemDelegate: class {
    func didTapFavorite(_ gistItem: GistItem)
}

class GistItem {
    var gist:Gist
    var isFavorite:Bool
    
    init(_ gist: Gist, isFavorite: Bool = false) {
        self.gist = gist
        self.isFavorite = isFavorite
    }
}

class GistItemCell: UITableViewCell {
    
    weak var delegate: GistItemDelegate?
    var item: GistItem? {
        didSet {
            setup()
        }
    }
    

    // The favorite's button
     private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        //imageView.image = UIImage(named: "icon_favorite")
        //imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
     }()
    
    // The user's image
     private let userImage: UIImageView = {
         let imageView = UIImageView()
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleToFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     // The user's name
     private let userName: UILabel = {
         let label = UILabel()
         label.numberOfLines = 2
         label.textColor = .black
         label.textAlignment = .left
         label.font = .systemFont(ofSize: 17, weight: .bold)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    // The user's name
    private let gistType: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        selectionStyle = .none
        favoriteIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFavorite)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        guard let item = item else {
            return
        }
        
        userName.text = item.gist.owner?.login
        userImage.load(item.gist.owner?.photo)
        favoriteIcon.image = UIImage(named: item.isFavorite ? "icon_favorite_over" : "icon_favorite")
        
        gistType.text = nil
        if let types = item.gist.files?.compactMap({ $0.value.type }) {
            gistType.text = types.removeDuplicates().joined(separator: "\n")
        }
    }
    
    @objc private func didTapFavorite() {
        guard let item = item else {
            return
        }
        delegate?.didTapFavorite(item)
    }
}

extension GistItemCell {
    
    /// Adds the views to the main one
    private func addViews(){
        self.contentView.addSubview(gistType)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(userImage)
        self.contentView.addSubview(favoriteIcon)
    }
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            userImage.widthAnchor.constraint(equalToConstant: 45),
            userImage.heightAnchor.constraint(equalToConstant: 45),
            userImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            userImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            
            userName.topAnchor.constraint(equalTo: userImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 15),
            userName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            
            gistType.topAnchor.constraint(equalTo: userName.bottomAnchor),
            gistType.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            gistType.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            gistType.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            
            favoriteIcon.widthAnchor   .constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor  .constraint(equalToConstant: 20),
            favoriteIcon.topAnchor     .constraint(equalTo: userName.topAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
        ])
    }
}
