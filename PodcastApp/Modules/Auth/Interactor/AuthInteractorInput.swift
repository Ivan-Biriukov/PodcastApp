import UIKit

protocol AuthInteractorInput {
    func loginUser(with email: String, and password: String, completion: @escaping (Result<String?, Error>) -> Void)
    func loginWithGoogle(view: UIViewController, completion: @escaping (Result<String?, Error>) -> Void)
    func registerUser(with email: String, and password: String,
                      and confirmPassword: String,
                      completion: @escaping (Result<String?, Error>) -> Void)
}
