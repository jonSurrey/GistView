//
//  Gist.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

class GistItem: Codable {
    var gist:Gist
    var isFavorite:Bool
    
    init(_ gist: Gist, isFavorite: Bool = false) {
        self.gist = gist
        self.isFavorite = isFavorite
    }
}

struct Gist:Codable {
    
    let id: String?
    let owner: Owner?
    var files: [String:GistFile]?
    let createdAt: String?
    let description: String?
    
    init(id: String? = nil, _ owner: Owner? = nil, _ files: [String:GistFile]? = nil, _ createdAt: String? = nil, _ description: String? = nil) {
        self.id = id
        self.owner = owner
        self.files = files
        self.createdAt = createdAt
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case createdAt = "created_at"
        case files
        case owner
    }
}

struct Owner:Codable {
    
    let login: String?
    let photo: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case photo = "avatar_url"
        case url
    }
}

struct GistFile:Codable {
    
    let filename: String?
    let type: String?
    let language: String?
    let raw: String?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case raw = "raw_url"
        case size
    }
}


