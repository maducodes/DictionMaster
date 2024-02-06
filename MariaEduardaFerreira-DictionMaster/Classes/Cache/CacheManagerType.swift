protocol CacheManagerType {
    func saveToCache(search: String, result: [SearchResultResponse])
    func getFromCache(search: String) -> [SearchResultResponse]?
    func continueToSearch(search: String) -> Bool
}
