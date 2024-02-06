import UIKit

final class CacheItem {
    let results: [SearchResultResponse]
    let creationDate: Date

    init(results: [SearchResultResponse]) {
        self.results = results
        self.creationDate = Date()
    }
}
