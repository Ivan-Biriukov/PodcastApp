import Foundation
import CryptoKit

enum NetworkEnvironment {
    case PocastsV1
}

enum PodcastAPI {
    case getTrendingsCategoryes(safe: Bool)
    case getResultFromSelectedTrending(categoryName: String, resultsCount: Int)
    case getPodcastsByFeedID(id: Int)
}

extension PodcastAPI: EndPointType {
    
    var apiKey: String {
        return "75GJGPAYJRNUG25FH4LK"
    }
    
    var apiSecret: String {
        return "GLQE8eyrL3^$sxJd7Y6mXb7MJgUKKmN2JhSfcV39"
    }
    
    var apiHeaderTime: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    var data4Hash : String {
        return apiKey + apiSecret + "\(apiHeaderTime)"
    }
    
    var inputData: Data {
        return Data(data4Hash.utf8)
    }
    
    var hashString: String {
        let hashed = Insecure.SHA1.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .PocastsV1:
            return "https://api.podcastindex.org/api/1.0/"
        }
    }
        
        var baseUrl: URL {
            guard let url = URL(string: environmentBaseUrl) else { fatalError("Unknown base URL") }
            return url
        }
        
        var path: String {
            switch self {
            case .getTrendingsCategoryes:
                return "categories/list"
            case .getResultFromSelectedTrending:
                return "search/bytitle"
            case .getPodcastsByFeedID:
                return "podcasts/byfeedid"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getTrendingsCategoryes:
                return .get
            case .getResultFromSelectedTrending:
                return .get
            case .getPodcastsByFeedID(id: let id):
                return .get
            }
        }
        
        var task: HTTPTask {
            switch self {
            case .getTrendingsCategoryes(safe: let safe):
                return .request(
                    bodyParam: nil,
                    urlParam: ["pretty" : "\(safe)"]
                )

            case .getResultFromSelectedTrending(categoryName: let categoryName, resultsCount: let resultsCount):
                return .request(
                    bodyParam: nil,
                    urlParam: ["q" : categoryName , "max": "\(resultsCount)"]
                )
            case .getPodcastsByFeedID(id: let id):
                return .request(
                    bodyParam: nil,
                    urlParam: nil
             //           "?id=\(id)&pretty"
                )
            }
        }
        
        var header: HTTPHeader? {
            return [
                "X-Auth-Date": "\(apiHeaderTime)",
                "X-Auth-Key": apiKey,
                "Authorization": hashString,
                "User-Agent": "PodcastApp/1.0"
                ]
        }
    }


//Key: 75GJGPAYJRNUG25FH4LK
//Secret: GLQE8eyrL3^$sxJd7Y6mXb7MJgUKKmN2JhSfcV39
