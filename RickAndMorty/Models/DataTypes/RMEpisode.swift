//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
}

