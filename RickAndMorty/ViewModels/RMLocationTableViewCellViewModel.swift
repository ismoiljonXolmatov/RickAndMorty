//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 27.07.1444 (AH).
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    
    let location: RMLocation
    
    init (location: RMLocation) {
        self.init(location: location)
    }
    
    public var name: String {
        return location.name
    }
    public var type: String? {
       return location.type
    }
    public var dimention: String {
        return location.name
    }
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(location.id)
        hasher.combine(dimention)
    }
}

