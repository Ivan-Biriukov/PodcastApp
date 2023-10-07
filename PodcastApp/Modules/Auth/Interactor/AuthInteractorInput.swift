import UIKit
import FirebaseAuth

protocol AuthInteractorInput {
    func loginUser(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void)
    func loginWithGoogle(view: UIViewController, completion: @escaping (Result<User, Error>) -> Void)
    func registerUser(with email: String, and password: String,
                      and confirmPassword: String,
                      completion: @escaping (Result<User, Error>) -> Void)
}
