import Foundation

final class ExampleService {
    
}

extension ExampleService: ExampleServiceProtocol {
    
    func createUser(completion: @escaping (Result<Bool, Error>) -> ()) {
        completion(.success(false))
    }
}
