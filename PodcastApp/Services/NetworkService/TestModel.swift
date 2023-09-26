import Foundation

struct TestPostModel {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension TestPostModel: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }
}
