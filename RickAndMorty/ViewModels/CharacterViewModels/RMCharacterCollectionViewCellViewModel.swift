//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 10.07.1444 (AH).
//

import Foundation

struct RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    let characterName: String
    let characterStatus: RMCharacterStatus
    let characterImageURL: URL?
    
    
    
    
    // MARK: Init
    init(characterName: String, characterStatusText: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatusText
        self.characterImageURL = characterImageURL
    }
    public var characterStatusText: String {
       return "Status: \(characterStatus.text )"
    }
    public func fetchImage(completion: @escaping ((Result<Data, Error>) -> Void)) {
        // MARK: Abstract to Image Manager
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url, completion: completion)
        
}
    
    // MARK: - Hashable
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }

    
}
