import Foundation

struct GenresModel: Codable {
    let genres: [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
    }
}
