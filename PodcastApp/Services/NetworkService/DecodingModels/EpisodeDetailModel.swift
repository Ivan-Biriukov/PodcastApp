import Foundation

struct EpisodeDetailModel: Codable {
    let items : [Item]
    let count : Int // total episods count
    let query : String // podcast parrent ID in string
}

struct Item: Codable {
    let id : Int
    let title : String
    let description : String
    let enclosureUrl : String  // Link to current mp3 file
    let enclosureType : String // file type and format
    let duration : Int // in seconds
    let episode : Int? // episode number of podcast list
    let feedImage : String // image of podcast
    let feedId : Int // podcast parent id
    let feedLanguage : String // podcast language
}
