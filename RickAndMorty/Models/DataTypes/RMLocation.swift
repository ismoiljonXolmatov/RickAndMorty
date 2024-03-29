//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

