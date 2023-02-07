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
    let air_date: Date
    let episode: String
    let url: String
    let created: String
    let characters: [String]
    
}

