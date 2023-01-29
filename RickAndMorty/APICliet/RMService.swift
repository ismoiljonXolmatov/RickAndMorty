//
//  RMService.swift
//  RickAndMorty
//
//  Created by Apple on 08.07.1444 (AH).
//

import Foundation

///Piremery API service object to get Rick and Morty data

final class RMService {
    
    ///Shared singletion instence
    static let shared = RMService()
    
    ///Privetized Constructer
    private init() {}
    
    ///Send rick and Morty API call
    /// - request: Request instence
    /// - completion: Callback with data or error
    private func exacute(_ request: RMRequest,completion: @escaping () -> Void ) {
        
    }
}
