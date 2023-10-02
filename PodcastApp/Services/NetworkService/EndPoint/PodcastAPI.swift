import Foundation

enum NetworkEnvironment {
    case PocastsV1
}

enum PodcastAPI { 
    case getCategories(page: Int) // page = 1 if we want to get all genres / page = 0 if we want get only populars
    case getHomeViewPopularCategories(genreId: String, pageNumber: Int)
    case getDetailPodcast(q: String, type: String, page_size: Int) // q - search term, type - episode, podcast, curated, page_size - count of results (1...10)  (for HomeView tableView use episode)
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
            case.getDetailPodcast:
                return "api/v2/search"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getCategories:
                return .get
            case .getHomeViewPopularCategories:
                return .get
            case .getDetailPodcast: // .searchPodcasts:
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
            case .getDetailPodcast(q: let q, type: let type, page_size: let page_size):
                return .request(
                    bodyParam: nil,
                    urlParam: ["q": q, "type": type, "page_size": page_size]
                )
            }

        }
        
        var header: HTTPHeader? {
            return [
                "X-ListenAPI-Key": "14dbbb7efd164f88b76be3727a5c32df",
                "Content-Type": "application/json"
                ]
        }
    }

//6797ac2453a5405d8799a56fc4c8384f  - limited
//396ff92be9a743feb4421b09a51fa56c  - limited
//14dbbb7efd164f88b76be3727a5c32df
