//
//  RmEpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import UIKit

class RMEpisodeDetailViewModel {
    
    private let endPointURL: URL?
    
    init(endPointURL: URL?) {
        self.endPointURL = endPointURL
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endPointURL,  let request = RMRequest(url: url) else {
            return
        }
        RMService.shared.exacute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure:
                break
                
            }
        }
    }

}
