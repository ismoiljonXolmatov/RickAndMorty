//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by Apple on 08.07.1444 (AH).
//

import Foundation

/// Represents unique API endpoint

@frozen enum RMEndPoint: String, Hashable, CaseIterable {
    ///Endpoint to get loacation info
    case location
    
    ///Endpoint to get loacation info
    case episode
    
    ///Endpoint to get character info
    case character
    

}
