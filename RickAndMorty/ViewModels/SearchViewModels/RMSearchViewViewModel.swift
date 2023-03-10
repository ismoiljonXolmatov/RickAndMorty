//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import Foundation

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    
    private var searchText = ""

    private var optionMapUpdatedBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchResultHandler: ((RMSearchResultViewViewModel)-> Void)?
    
    private var noResultsHandler: (()-> Void)?
    
    private var searchResultModel: Codable?
    
    // MARK:  - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
   
    // MARK:  - Public
    
    public func registerSearchResultHandler(_ block: @escaping (RMSearchResultViewViewModel) -> Void) {
        self.searchResultHandler = block
    }
    
    public func registerNoResultHandler(_ block: @escaping () -> Void) {
        self.noResultsHandler = block
    }
   
    
    public func exacuteSerch() {
        print("SearchText is : \(searchText)")
        
        // build argument
        var  queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        // Add Options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({_, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = RMRequest(endpoint: config.type.endpoint, queryParametrs: queryParams)
        switch config.type.endpoint {
        case .character:
            makeResultAPICall(RMGetAllCharactersResponse.self, request: request)
        case .episode:
            makeResultAPICall(RMGetAllEpsiodesResponse.self, request: request)
        case .location:
            makeResultAPICall(RMGetallLocationResponse.self, request: request)
        }
    }
              
            private  func makeResultAPICall<T: Codable>( _ type: T.Type, request: RMRequest) {
            RMService.shared.exacute(request, expecting: type) { [weak self] result  in
            // verify result no result , error
            switch result {
            case .success(let model):
                self?.prossesSearchResults(model: model)
            case .failure:
                self?.handleNoResult()
                break 
            }
        }
    }
    
    private func prossesSearchResults(model: Codable ) {
        var resultsVM: RMSearchResultViewViewModel?
        if let characterResults = model as? RMGetAllCharactersResponse {
            resultsVM = .characters(characterResults.results.compactMap({
                RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatusText: $0.status,
                    characterImageURL: URL(string: $0.image))
            }))
        }
        
        else if let episodeResults = model as? RMGetAllEpsiodesResponse {
            resultsVM = .episode(episodeResults.results.compactMap({
                RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
            }))
        }
        
        else if let locationResults = model as? RMGetallLocationResponse {
            resultsVM = .locations(locationResults.results.compactMap({
                RMLocationTableViewCellViewModel(location: $0)
            }))
  
        }
        

        if let results = resultsVM {
            self.searchResultModel = model
            self.searchResultHandler?(results)
            
                   } else {
            // fall back error
            handleNoResult()
        }
    }
    
    private func handleNoResult() {
        print("No result")
        noResultsHandler?()
    }
    
    // MARK: - Publics
    public func set(query text: String) {
        self.searchText = text
     
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdatedBlock?(tuple)
    }
    
    public func registerOptionChangeBlock( _ block : @escaping((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdatedBlock = block
    }
    public func locationSearchResult(at index: Int) -> RMLocation? {
        guard let searchModel = searchResultModel as? RMGetallLocationResponse else {
            return nil
        }
        return searchModel.results[index]
    }
}

