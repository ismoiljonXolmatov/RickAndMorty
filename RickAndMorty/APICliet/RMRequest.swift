//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Apple on 08.07.1444 (AH).
//

import Foundation
/// Objectst that represents a single API Call
final class RMRequest {
    ///API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    ///Desired endpoint
     let endpoint: RMEndPoint

    ///Path Components for API, if any
    private let pathComponents: [String]
    
    //Query arguments for API, if any
    private let queryParametrs: [URLQueryItem]
    
    /// Constracted url for the API  request i string format
    private var urlString: String {
        var string = Constants.baseURL
        string +=  "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        if !queryParametrs.isEmpty {
            string += "?"
            let argumentString = queryParametrs.compactMap({
                guard let value = $0.value else  {
                    return nil
                }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    ///Compudet & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    /// Desired https method
    public let httpsMethod = "GET"
    
    
    // MARK: - public
    
    public init(
        endpoint: RMEndPoint,
        pathComponents: [String] = [],
        queryParametrs: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParametrs = queryParametrs
    }
    /// Attampt to create request
    /// - Parametr url:  Url tp parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURL) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndPoint = RMEndPoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndPoint, pathComponents: pathComponents)
                    return
                }
            }
            
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endPointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndPoint = RMEndPoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndPoint, queryParametrs: queryItems)
                    return
                }
                
            }
            
        }
        return nil
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
    static let listLoactionsRequest = RMRequest(endpoint: .location)
}
