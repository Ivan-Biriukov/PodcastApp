import Foundation

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
    
}

extension AuthPresenter: AuthViewDelegate {
    func didTapLogin() {
        print("LOGIN")
    }
    
    func didTapRegister() {
        print("REGISTER")
    }
    
    func didTapGoogle() {
        print("GOOGLE")
    }
}
