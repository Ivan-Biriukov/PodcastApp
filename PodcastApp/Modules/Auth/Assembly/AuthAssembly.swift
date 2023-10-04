import UIKit

final class AuthAssembly {
    static func assemble() -> UIViewController {
        let authService = AuthService()
        let router = AuthRouter()
        let interactor = AuthInteractor(authService: authService)
        let presenter = AuthPresenter(interactor: interactor, router: router)
        let view = AuthViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
