import Foundation

enum Result<String> {
    case success
    case failture(String)
}

enum NetworkResponse: String {
    case success
    case badRequest = "Bad Request"
    case failed
    case noData
}

protocol NetworkManagerProtocol {
    func fetchPosts(completion: @escaping(_ posts: [TestPostModel]?, _ error: String?) -> ())
}

final class NetworkManager {
    static let environment: NetworkEnvironment = .test
    private let router = Router<TestAPI>()
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        default:
            return .failture(NetworkResponse.failed.rawValue)
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func fetchPosts(completion: @escaping ([TestPostModel]?, String?) -> ()) {
        router.request(.posts) { data, response, error in
            if error != nil {
                completion(nil, "Something went wrong")
                print(error!)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([TestPostModel].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.failed.rawValue)
                    }
                case .failture(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
