import UIKit

final class AuthAssembly {
    static func assemble() -> UIViewController {
        let authService = AuthService()
        let router = AuthRouter()
        let interactor = AuthInteractor(authService: authService)
        let presenter = AuthPresenter(interactor: interactor, router: router)
        let authView = AuthView(delegate: presenter)
        let view = AuthViewController(presenter: presenter, view: authView)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
