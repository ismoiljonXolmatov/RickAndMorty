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
    
    enum RMSersiveError: Error {
        case failedToCreateRequest
        case failedToGetData
        
    }
    ///Send rick and Morty API call
    /// - request: Request instence
    ///  - expecting: type of object we expect to get back
    /// - completion: Callback with data or error
    public func exacute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error >) -> Void ) {
        
        guard let URLRequest = self.request(from: request) else {
            completion(.failure(RMSersiveError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ??  RMSersiveError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else  {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpsMethod
        return request 
    }
}
