//
//  RMSearchResultViewViewmodel.swift
//  RickAndMorty
//
//  Created by Apple on 08.08.1444 (AH).
//

import Foundation

enum RMSearchResultViewViewModel {
      case characters([RMCharacterCollectionViewCellViewModel])
      case episode([RMCharacterEpisodeCollectionViewCellViewModel])
      case locations([RMLocationTableViewCellViewModel]) 
}
