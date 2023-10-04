import Foundation

protocol AuthPresenterProtocol {
    func loginUser(email: String, password: String)
    func registerUser(email: String, password: String, confirmPassword: String)
    func loginWithGoogle()
}
