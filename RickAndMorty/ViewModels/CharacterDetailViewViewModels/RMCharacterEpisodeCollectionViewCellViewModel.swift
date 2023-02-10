//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String {
        get
    }
    var air_date: String {
        get
    }
    var episode: String {
        get
    }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var dateBlock: ((RMEpisodeDataRender ) -> Void)?
     
    private var episode: RMEpisode?  {
        didSet{
            guard let model = episode else {
                return
            }
             dateBlock?(model)  
        }
    }
    
    private var isFatching: Bool = false
    
    //MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    //MARK: - Public
    
    public func registerForData( _ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dateBlock = block
        
    }

    
    
    public func fetchEpisode() {
        guard !isFatching else {
            if let model = episode  {
                dateBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let request = RMRequest(url: url) else {
            return
        }
        
        isFatching = true
        RMService.shared.exacute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
  
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
         
    }
    
}
