//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 17.08.1444 (AH).
//

import Foundation


protocol RMLocationDetailViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel  {
     
    private let endPointURL: URL?
     
     public weak var delegate: RMLocationDetailViewModelDelegate?
     
    private var dataTuple: (
        location: RMLocation,
        characters: [RMCharacter])? {
            didSet {
                createCellViewModels()
                
                delegate?.didFetchLocationDetails()
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
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels  = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
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
    /// Fetch backing location model
    public func fetchLocationData() {
        guard let url = endPointURL, let request = RMRequest(url: url) else {
            return
        }
        RMService.shared.exacute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchReletedCharacters(location: model)
                
            case .failure:
                break
            }
        }
    }
    
    private func fetchReletedCharacters(location: RMLocation) {
        let characterUrls: [URL] = location.residents.compactMap({
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
                location: location,
                characters: characters)
        }
    }
     
     
}




