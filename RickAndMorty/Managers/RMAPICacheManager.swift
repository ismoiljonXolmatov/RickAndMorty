//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import Foundation
/// Manages in memory section scoped  API caches
final class RMAPICacheManager {
    
    private var cacheDictionary: [
        RMEndPoint: NSCache<NSString, NSData>
    ] = [:]
    
    
    
    init() {
        setUPCaches()
    }
    
    //MARK: - Public
    public func cachedResponse(with endpoint: RMEndPoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
        
    }
    public func setCache(with endpoint: RMEndPoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData , forKey: key) 
        
    }

    
    
    //MARK: - Private
    private func setUPCaches() {
        RMEndPoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
