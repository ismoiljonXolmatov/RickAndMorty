//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 12.07.1444 (AH).
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
