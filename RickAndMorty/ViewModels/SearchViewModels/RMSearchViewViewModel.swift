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
    
    private var searchREsultHandler: (()-> Void)?

    // MARK:  - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    // MARK:  - Public
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchREsultHandler = block
    }
    
    public func exacuteSerch() {
        //Test search text
        searchText = "Rick"

        // build argument
        var  queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText)
           ]
        // Add Options
          queryParams.append(contentsOf: optionMap.enumerated().compactMap({_, element in
              let key: RMSearchInputViewViewModel.DynamicOption = element.key
              let value: String = element.value
              return URLQueryItem(name: key.queryArgument, value: value)
          }))
                               
        let request = RMRequest(endpoint: config.type.endpoint, queryParametrs: queryParams)
        
        print(request.url?.absoluteString)
        
        RMService.shared.exacute(request, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Search results found \(model.results.count)")
            case .failure:
                break
            }
        }
        
        // send API Call
        
        // Notify view of results, no resluts, or error
    }
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
}
