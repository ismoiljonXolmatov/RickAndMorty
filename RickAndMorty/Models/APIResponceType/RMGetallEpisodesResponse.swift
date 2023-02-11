//
//  RMGetallEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Apple on 21.07.1444 (AH).
//

import Foundation

struct RMGetAllEpsiodesResponse: Codable {
    struct Info: Codable {
      var count: Int
      var pages: Int
      var next: String?
      var prev: String?
    }
    var info: Info
    let results: [RMEpisode]
}
