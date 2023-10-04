import Foundation

enum NetworkResponse: String {
    case success
    case badRequest = "Bad Request"
    case failed
    case noData
}

protocol NetworkManagerProtocol {
    func fetchTrending(safe: Bool,completion: @escaping (Result<Data, Error>) -> Void)
    func fetchResultsFromSelectedTrendings(categoryName: String, count: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchHomeViewPopulars(categoryName: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager {
    static let environment: NetworkEnvironment = .PocastsV1
    private let router = Router<PodcastAPI>()
}

extension NetworkManager: NetworkManagerProtocol {
    
    func fetchHomeViewPopulars(categoryName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getResultFromSelectedTrending(categoryName: categoryName, resultsCount: 1000)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
    
    
    func fetchResultsFromSelectedTrendings(categoryName: String, count: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getResultFromSelectedTrending(categoryName: categoryName, resultsCount: count)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
    
    
    func fetchTrending(safe: Bool, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getTrendingsCategoryes(safe: safe)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
}
