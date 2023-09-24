import Foundation

protocol ExampleServiceProtocol {
    func createUser(completion: @escaping (Result<Bool, Error>) -> ())
}
