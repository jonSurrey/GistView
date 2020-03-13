//
//  Service.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 10/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

// MARK: - GistServiceDelegate
protocol GistServiceDelegate: class {
    
    /// Notifies the result of the gists
    func didReceiveGists(_ gists:[Gist])
    
    /// Notifies that an error occured
    func onRequestError(_ error:String)
    
    /// Notifies hte there is no internet connection
    func noInternetConection()
}

// MARK: - GistService
class GistService {
    
    /// The provider with the request information
    private var provider: ProviderDelegate
    
    /// Callback to notify the caller of the request
    weak var delegate: GistServiceDelegate?
    
    init(_ provider: ProviderDelegate) {
        self.provider = provider
    }

    /// Performs the request to get the list of gists
    func getGistList(page: Int = 1) {
        provider.parameters = ["page": page]
        RequestManager<[Gist]>.get(to: provider) { (result) in
            switch result {
                case .success(let result):
                    self.delegate?.didReceiveGists(result)
                    break
                case .failure(let error):
                    self.delegate?.onRequestError(error)
                    break
                case .noInternetConection:
                    self.delegate?.noInternetConection()
                    break
            }
        }
    }
}
