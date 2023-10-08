import Foundation

struct SearchResultModel: Codable {
    let feeds : [SearchResult]
    let count : Int
}

struct SearchResult: Codable {
    let id : Int
    let title : String
    let description : String
    let author : String
    let image : String
    let language : String
    let episodeCount : Int
}
