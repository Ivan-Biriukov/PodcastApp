import Foundation

enum NetworkEnvironment {
    case test
}

enum TestAPI {
    case posts
}

extension TestAPI: EndPointType {
    
    var environmentBaseUrl: String {
        switch self {
        case .posts:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
    
    var baseUrl: URL {
        guard let url = URL(string: environmentBaseUrl) else { fatalError("Unknown base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .posts:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .posts:
            return .request
        }
    }
    
    var header: HTTPHeader? {
        switch self {
        case .posts:
            return nil
        }
    }
}
