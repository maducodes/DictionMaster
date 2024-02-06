import Foundation
import UIKit

final class CacheManager: CacheManagerType {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, CacheItem>()
    private var keys = Set<NSString>()
    private let limitRequests = 5
    private let expirationTimeInterval: TimeInterval = 24 * 60 * 60
    
    func saveToCache(search: String, result: [SearchResultResponse]) {
        let cacheItem = CacheItem(results: result)
        cache.setObject(cacheItem, forKey: search as NSString)
        keys.insert(search as NSString)
    }
    
    func getFromCache(search: String) -> [SearchResultResponse]? {
        removeExpiredItens()
        
        guard let cachedResult = cache.object(forKey: search as NSString)?.results else {
            return nil
        }
        
        return cachedResult
    }
    
    func continueToSearch(search: String) -> Bool {
        if getFromCache(search: search.lowercased()) != nil {
            return true
        }
        
        if keys.count < limitRequests {
            return true
        }
        
        return false
    }

    @objc
    private func removeExpiredItens() {
        let currentDate = Date()
        
        for key in keys {
            if let cachedObject = cache.object(forKey: key) {
                if currentDate.timeIntervalSince(cachedObject.creationDate) >= self.expirationTimeInterval {
                    cache.removeObject(forKey: key)
                    keys.remove(key)
                }
            }
        }
    }
}
