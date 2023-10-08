import Foundation
import UIKit

final class AuthPresenter {
    weak var view: AuthViewInput?
    
    private let interactor: AuthInteractorInput
    private let router: AuthRouterInput
    
    init(interactor: AuthInteractorInput, router: AuthRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    func loginUser(email: String, password: String) {
        interactor.loginUser(with: email, and: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.router.showSuccess(with: "Success")
                SavingManager.shared.fetchUser(for: user.uid) { [weak self] user in
                    if let user {
                        print(user)
                    } else {
                        print("Not found")
                    }
                }
            case .failure(let error):
                self?.router.showError(with: error.localizedDescription)
            }
        }
    }
    
    func registerUser(email: String, password: String, confirmPassword: String) {
        if password != confirmPassword {
            router.showError(with: "Password and repeat password don't match")
            return
        }
        
        if password.count < 6 {
            router.showError(with: "Password must be at least 6 characters")
            return
        }
        
        interactor.registerUser(with: email, and: password, and: confirmPassword) { [weak self] result in
            switch result {
            case .success(let user):
                self?.router.showSuccess(with: "Check your email to accept registration")
                print(user)
            case .failure(let error):
                self?.router.showError(with: error.localizedDescription)
            }
        }
    }
    
    func loginWithGoogle() {
        interactor.loginWithGoogle(view: view as! UIViewController) { [weak self] result in
            switch result {
            case .success(let user):
                self?.router.showSuccess(with: "Success")
                SavingManager.shared.fetchUser(for: user.uid) { [weak self] realmUser in
                    if let realmUser {
                        self?.router.routeToMainApp(user: realmUser)
                    } else {
                        self?.router.routeToContinueRegister(user: user)
                    }
                }
            case .failure(let error):
                self?.router.showError(with: error.localizedDescription)
            }
        }
    }
}
