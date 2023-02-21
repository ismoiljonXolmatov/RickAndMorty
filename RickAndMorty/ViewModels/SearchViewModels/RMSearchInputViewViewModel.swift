//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import Foundation

final class RMSearchInputViewViewModel {
    
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = " Location Type"
    }
    
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    public var hasDynamicOption: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode :
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    public var placeHolderText: String {
        switch self.type {
        case .character:
            return "Search Character name"
        case .location:
            return "Search Location"
        case .episode:
            return "Search Episode"
        }
    }
}

