import Foundation

struct TrendingsNamesModel: Codable {
    let feeds : [Feed]
}

struct Feed: Codable {
    let id : Int
    let name : String
}
