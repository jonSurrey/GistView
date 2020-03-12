//
//  Service.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 10/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

// MARK: -
protocol GistServiceDelegate: class {
    
    /// Notifies the result of the gists
    func didReceiveGists(_ gists:[Gist])
    
    /// Notifies the result of the details of a gist
    func didReceiveDetailOf(_ gist:Gist)
    
    /// Notifies that an error occured
    func onRequestError(_ error:String)
    
    /// Notifies hte there is no internet connection
    func noInternetConection()
}

// MARK: -
extension GistServiceDelegate {
    
    func didReceiveGists(_ gists:[Gist]) { }
    
    func didReceiveDetailOf(_ gist:Gist) { }
}

// MARK: -
class GistService {
    
    ///
    private var provider: ProviderDelegate
    
    /// Callback to notify the caller of the request
    weak var delegate: GistServiceDelegate?
    
    init(_ provider: ProviderDelegate) {
        self.provider = provider
    }
    
    ///
    func getGistList(page: Int = 1) {
        provider.parameters = ["page":page]
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
