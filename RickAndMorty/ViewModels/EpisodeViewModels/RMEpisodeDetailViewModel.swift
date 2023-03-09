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
     
    private var dataTuple: (
        episode: RMEpisode,
        characters: [RMCharacter])? {
            didSet {
                createCellViewModels()
                
                delegate?.didFetchepisodeDetails()
            }
        }
    
    enum sectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    public private(set) var cellViewModels: [sectionType] = []
    
     // MARK: - Init
    init(endPointURL: URL?) {
        self.endPointURL = endPointURL
        
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
            
        }
        return dataTuple.characters[index ]
    }
    
    
    private  func  createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = episode.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels  = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel.init(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageURL: URL(string: character.image))
             }))
        ]
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
            self.dataTuple = (
                episode: episode,
                characters: characters)
        }
    }
     
     
}



