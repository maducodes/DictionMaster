import Foundation

struct SearchResultResponse: Codable {
    let word: String
    let phonetic: String
    let phonetics: [Phonetics]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

struct Phonetics: Codable {
    let text: String
    let audio: String?
    let sourceUrl: String?
    let license: License?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]
    let antonyms: [String]
}

struct Definition: Codable {
    let definition: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String?
}

struct License: Codable {
    let name: String
    let url: String
}
