//
//  RMChracter.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String?
    let gender: RMCharacterGender
    let origion: RMOrigin?
    let location: RMSingeLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
