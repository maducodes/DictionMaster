struct Strings {
    //MARK: Search
    static let searchPlaceholder = "Type a word..."
    static let searchButtonTitle = "Search"
    
    //MARK: Language component
    static let english = "english"
    
    //MARK: Search Result
    static func searchResultTitle(_ searchTerm: String) -> String {
        return "That’s it for “\(searchTerm)”! ☺️"
    }
    static let searchResultDescription = "Try another search now!"
    static let newSearchButtonTitle = "New Search"
    
    //MARK: Purchase
    static let purchaseTitle = "Subscribe now to get unlimited searches and full access to all features."
    static let purchaseDescription = "\(daysFree), then only \(price) per year. Cancel anytime."
    static let purchaseButtonTitle = "Subscribe"
    
    static let unlimited = "unlimited"
    static let all = "all"
    static let features = "features."
    static let daysFree = "7 Days Free"
    static let price = "$19,99"
    
    
    //MARK: Acessibility
    static func selectedLanguage(_ language: String) -> String {
        return "selected language: \(language)"
    }
    static let audioSpeaker = "hear pronunciation"
    static let audioSpeakerHint = "tap to hear the pronunciation"
    static let language = "en"
    
    //MARK: Error Alert
    static let ok = "OK!"
    static let errorAlertTitle = "OOPS!"
    static let errorAlertDescription = "The audio URL is not valid."
}
