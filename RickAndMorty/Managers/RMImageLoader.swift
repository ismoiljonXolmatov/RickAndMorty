//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Apple on 17.07.1444 (AH).
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private init() {}
    private var imageDataCache = NSCache<NSString, NSData>()
    
    
    /// Get image content with URi
    ///  - Parametrs:
    ///   - url: Source url
    ///    - completion: Callback
    
  public  func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
      let key = url.absoluteString as NSString
      if let data = imageDataCache.object(forKey: key) {
          completion(.success(data as Data)) // NSData = Data | NSString = String
          return
      }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
