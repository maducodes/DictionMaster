import Foundation

final class SearchResultService: SearchResultServiceType {
    private let baseURL: String = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    private let session = URLSession.shared
    private let cache = CacheManager.shared
    
    func fetchSearch(search: String, _ completion: @escaping ([SearchResultResponse]?) -> Void) {
        if let resultCached = cache.getFromCache(search: search.lowercased()) {
            completion(resultCached)
        } else {
            let urlString = "\(baseURL)\(search)"
            guard let url = URL(string: urlString) else { return }
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let searchResultResponse = try JSONDecoder().decode([SearchResultResponse].self, from: data)
                        self.cache.saveToCache(search: search.lowercased(),
                                               result: searchResultResponse)
                        completion(searchResultResponse)
                    } catch {
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        }
    }
}
