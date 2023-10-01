import Foundation

enum NetworkEnvironment {
    case PocastsV1
}

enum PodcastAPI { 
    case getCategories(page: Int)
    case getHomeViewPopularCategories(genreId: String, pageNumber: Int)
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
            case .getHomeViewPopularCategories:
                return "api/v2/best_podcasts"
//            case .searchPodcasts:
//                return "api/v2/search"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getCategories: // .searchPodcasts:
                return .get
            case .getHomeViewPopularCategories:
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
                
            case .getHomeViewPopularCategories(genreId: let genreId, pageNumber: let pageNumber):
                return .request(
                    bodyParam: nil,
                    urlParam: ["genre_id": "\(genreId)", "page": pageNumber, "sort": "listen_score", "safe_mode": 1]
                )
            }
                
//            case .searchPodcasts(text: let text, offset: <#T##Int#>, limit: <#T##Int#>):
//                return [
//                    "q": text,
//                    
//                ]

        }
        
        var header: HTTPHeader? {
            return [
                "X-ListenAPI-Key": "396ff92be9a743feb4421b09a51fa56c",
                "Content-Type": "application/json"
                ]
        }
    }

//6797ac2453a5405d8799a56fc4c8384f
