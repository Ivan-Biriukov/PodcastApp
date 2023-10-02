import Foundation

struct DetailResultModel: Codable {
    let results : [SearchResult]
}

struct SearchResult: Codable {
    let id: String
    let audio: String  // URLString
    let image: String  // URLString
    let audio_length_sec: Int
    let title_original: String
    let podcast : Podcast
}

struct Podcast: Codable {
    let publisher_original: String? // Probably a Author Name
}
