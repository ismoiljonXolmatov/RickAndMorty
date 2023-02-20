//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 27.07.1444 (AH).
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFatchInitialLocations()
}

 final class RMLocationViewViewModel {
    
      weak var delegate: RMLocationViewViewModelDelegate?
     
    private var apiInfo: RMGetallLocationResponse.Info?
    
     private var locations: [RMLocation] = [] {
         didSet {
             for location in locations {
                 let cellViewModel = RMLocationTableViewCellViewModel(location: location )
                 if !cellViewModels.contains(cellViewModel){
                     cellViewModels.append(cellViewModel)
                 }
                 
             }
         }
     }
    
     public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
     
    init() {}
    
    public func fetchLoactions() {
        RMService.shared.exacute(.listLoactionsRequest, expecting: RMGetallLocationResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFatchInitialLocations()
                }
            case .failure(let error):
                break
            }
        }
    }
    private var hasMorreResults: Bool {
        return false
    }
    
    
}
