import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth

protocol AuthServiceProtocol {
    func createUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ())
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ())
    func loginWithGoogle(view: UIViewController, completion: @escaping (Result<User, Error>) -> ())
    func logout(completion: @escaping (Result<Bool, Error>) -> ())
    func isAuthorised() -> Bool
}

final class AuthService: AuthServiceProtocol {
    func createUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            result?.user.sendEmailVerification(completion: { error in
                if let error {
                    completion(.failure(error))
                    return
                }
                guard let user = result?.user else {
                    completion(.failure(AuthError.unknownError))
                    return
                }
                completion(.success(user))
            })
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let current = result?.user, current.isEmailVerified {
                completion(.success(current))
            } else {
                completion(.failure(AuthError.emailNotVerified))
            }
        }
    }
    
    func loginWithGoogle(view: UIViewController, completion: @escaping (Result<User, Error>) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthError.unknownError))
                return
            }
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let user = result?.user else {
                    completion(.failure(AuthError.unknownError))
                    return
                }
                
                completion(.success(user))
            }
        }
    }
    
    func isAuthorised() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func logout(completion: @escaping (Result<Bool, Error>) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
}
