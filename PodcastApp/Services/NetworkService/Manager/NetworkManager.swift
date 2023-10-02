import Foundation

enum NetworkResponse: String {
    case success
    case badRequest = "Bad Request"
    case failed
    case noData
}

protocol NetworkManagerProtocol {
    func fetchCategoriest(page: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchHomeViewPopularCategories(genreId: String, pageNumber: Int,completion: @escaping (Result<Data, Error>) -> Void)
    func fetchSearched(q: String, type: String, page_size: Int, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager {
    static let environment: NetworkEnvironment = .PocastsV1
    private let router = Router<PodcastAPI>()
}

extension NetworkManager: NetworkManagerProtocol {
    
    func fetchHomeViewPopularCategories(genreId: String, pageNumber: Int,completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getHomeViewPopularCategories(genreId: genreId, pageNumber: pageNumber)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
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
    
    func fetchSearched(q: String, type: String, page_size: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getDetailPodcast(q: q, type: type, page_size: page_size)) { data, response, error in
            guard error == nil, let data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
}
