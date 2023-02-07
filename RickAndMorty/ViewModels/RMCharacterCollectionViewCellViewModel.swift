//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 10.07.1444 (AH).
//

import Foundation

struct RMCharacterCollectionViewCellViewModel {
    
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
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
