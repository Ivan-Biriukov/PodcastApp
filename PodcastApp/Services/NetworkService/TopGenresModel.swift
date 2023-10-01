import Foundation

struct TopGenresModel: Codable {
    let id: Int
    let name: String
    let total: Int
    let podcasts : [Podcasts]
}

struct Podcasts: Codable {
    let id: String
    let type: String
    let image: String
    let title: String
    let country: String
    let language: String
    let description: String
    let total_episodes: Int
}
