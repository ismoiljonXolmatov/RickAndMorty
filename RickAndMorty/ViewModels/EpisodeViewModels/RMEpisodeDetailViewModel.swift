//
//  RmEpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import UIKit

protocol RMEpisodeDetailViewModelDelegate: AnyObject {
    func didFetchepisodeDetails()
}

final class RMEpisodeDetailViewViewModel  {
     
    private let endPointURL: URL?
     
     public weak var delegate: RMEpisodeDetailViewModelDelegate?
     
     private var dataTuple: (RMEpisode, [RMCharacter])? {
         didSet {
             delegate?.didFetchepisodeDetails()
         }
     }
    enum sectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
    }
    public private(set) var section: [sectionType] = []
    
     // MARK: - Init
    init(endPointURL: URL?) {
        self.endPointURL = endPointURL
        
    }
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endPointURL, let request = RMRequest(url: url) else {
            return
        }
        RMService.shared.exacute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchReletedCharacters(episode: model)
                
            case .failure:
                break
            }
        }
    }
    
    private func fetchReletedCharacters(episode: RMEpisode) {
        let characterUrls: [URL] = episode.characters.compactMap({
            return URL(string: $0)
        })
        let requests: [RMRequest] = characterUrls.compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
         var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.exacute(request, expecting: RMCharacter.self) { result in
                switch result {
                    case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.dataTuple = (episode, characters)
        }
    }
     
     
}


