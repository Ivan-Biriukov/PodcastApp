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
    
    
    
    
    func fetchCategoriest(page: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchHomeViewPopularCategories(genreId: String, pageNumber: Int,completion: @escaping (Result<Data, Error>) -> Void)
    func fetchSearched(q: String, type: String, page_size: Int, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager {
    static let environment: NetworkEnvironment = .PocastsV1
    private let router = Router<PodcastAPI>()
}

extension NetworkManager: NetworkManagerProtocol {
    
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
    
    
    func fetchHomeViewPopularCategories(genreId: String, pageNumber: Int,completion: @escaping (Result<Data, Error>) -> Void) {
//        router.request(.getHomeViewPopularCategories(genreId: genreId, pageNumber: pageNumber)) { data, response, error in
//            guard error == nil, let data else {
//                completion(.failure(error!))
//                return
//            }
//            completion(.success(data))
//        }
    }
    
    func fetchCategoriest(page: Int, completion: @escaping (Result<Data, Error>) -> Void) {
//        router.request(.getCategories(page: page)) { data, response, error in
//            guard error == nil, let data else {
//                completion(.failure(error!))
//                return
//            }
//            completion(.success(data))
//        }
    }
    
    func fetchSearched(q: String, type: String, page_size: Int, completion: @escaping (Result<Data, Error>) -> Void) {
//        router.request(.getDetailPodcast(q: q, type: type, page_size: page_size)) { data, response, error in
//            guard error == nil, let data else {
//                completion(.failure(error!))
//                return
//            }
//            completion(.success(data))
//        }
    }
}
