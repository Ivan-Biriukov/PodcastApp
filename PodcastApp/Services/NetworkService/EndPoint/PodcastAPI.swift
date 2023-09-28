import Foundation

enum NetworkEnvironment {
    case PocastsV1
}

enum PodcastAPI { 
    case getCategories(page: Int)
}

extension PodcastAPI: EndPointType {
    
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .PocastsV1:
            return "https://listen-api.listennotes.com/"
        }
    }
        
        var baseUrl: URL {
            guard let url = URL(string: environmentBaseUrl) else { fatalError("Unknown base URL") }
            return url
        }
        
        var path: String {
            switch self {
            case .getCategories:
                return "api/v2/genres"
//            case .searchPodcasts:
//                return "api/v2/search"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getCategories: // .searchPodcasts:
                return .get
            }
        }
        
        var task: HTTPTask {
            switch self {
            case .getCategories(page: let page):
                return .request(
                    bodyParam: nil,
                    urlParam: ["top_level_only": "\(page)"]
                )
//            case .searchPodcasts(text: let text, offset: <#T##Int#>, limit: <#T##Int#>):
//                return [
//                    "q": text,
//                    
//                ]
            }
        }
        
        var header: HTTPHeader? {
            return [
                "X-ListenAPI-Key": "6797ac2453a5405d8799a56fc4c8384f",
                "Content-Type": "application/json"
                ]
        }
    }
