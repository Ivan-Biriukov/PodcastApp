import Foundation

enum NetworkResponse: String {
    case success
    case badRequest = "Bad Request"
    case failed
    case noData
}

protocol NetworkManagerProtocol {
    func fetchCategoriest(page: Int, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager {
    static let environment: NetworkEnvironment = .PocastsV1
    private let router = Router<PodcastAPI>()
}

extension NetworkManager: NetworkManagerProtocol {
    func dasd() {
        
    }
    func fetchCategoriest(page: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getCategories(page: page)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
    

    
//    func fetchPosts(completion: @escaping ([TestPostModel]?, String?) -> ()) {
//        router.request(.posts) { data, response, error in
//            if error != nil {
//                completion(nil, "Something went wrong")
//                print(error!)
//            }
//            
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue)
//                        return
//                    }
//                    do {
//                        let apiResponse = try JSONDecoder().decode([TestPostModel].self, from: responseData)
//                        completion(apiResponse, nil)
//                    } catch {
//                        completion(nil, NetworkResponse.failed.rawValue)
//                    }
//                case .failture(let error):
//                    completion(nil, error)
//                }
//            }
//        }
//    }
}
