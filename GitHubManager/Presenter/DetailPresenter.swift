//
//  DetailPresenter.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 07/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Foundation

// MARK: - DetailPresenterDelegate
protocol DetailPresenterDelegate {
    
    /// Gets the needed information from the current gist 
    func getGistData()
}

// MARK: - DetailPresenter
class DetailPresenter: DetailPresenterDelegate {
    
    /// Instance of the view
    private weak var view: DetailViewDelegate?
    
    /// The  gist object  used to fill the details. It should be private but we make it public for testing purposes
    var gist: Gist?
    
    /// Binds a view and a previous selected  gist  to this presenter
    func attach(to view: DetailViewDelegate, _ gist: Gist) {
        self.gist = gist
        self.view = view
    }
    
    func getGistData() {
        guard let gist = gist else { return }
        
        let name  = gist.owner?.login
        let image = gist.owner?.photo
        let files = formattFiles(gist.files)
        
        view?.displayUserName(name)
        view?.displayUserImage(image)
        view?.displayFiles(files)
    }
    
    /// Gets the files' information from the given dictionary and formats to a String
    private func formattFiles(_ files:[String : GistFile]?) -> String {
        if let files = files?.compactMap({ $0.value }) {
            let content = files.compactMap({
                "\($0.filename ?? "")\n- \($0.type ?? "")"
            })
            return content.joined(separator: "\n\n")
        }
        return ""
    }
}
