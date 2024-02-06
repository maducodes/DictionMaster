import UIKit

struct SearchResultViewModel {
    let word: String
    let phonetic: String?
    let meanings: [MeaningViewModel]
}

struct MeaningViewModel {
    let definition: NSMutableAttributedString
    let examples: [String?]
}
