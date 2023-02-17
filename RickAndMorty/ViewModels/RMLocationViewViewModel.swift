//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 27.07.1444 (AH).
//

import Foundation

 final class RMLocationViewViewModel /*: NSObject, UITableViewDelegate, UITableViewDataSource*/ { 
    
    
    
    
    private var loactions: [RMLocation] = []
    private var cellViewModels: [String] = []
    
    
    init() {
    }
    
    public func fetchLoactions() {
        RMService.shared.exacute(.listLoactionsRequest
                                 , expecting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private var hasMorreResults: Bool {
        return false
    }
    
      
}
