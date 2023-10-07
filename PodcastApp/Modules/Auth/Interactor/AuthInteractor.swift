import UIKit
import FirebaseAuth

final class AuthInteractor {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
}

extension AuthInteractor: AuthInteractorInput {
    func loginUser(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void) {
        authService.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loginWithGoogle(view: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        authService.loginWithGoogle(view: view, completion: completion)
    }
    
    func registerUser(with email: String, and password: String, and confirmPassword: String, completion: @escaping (Result<User, Error>) -> Void) {
        authService.createUser(email: email, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
