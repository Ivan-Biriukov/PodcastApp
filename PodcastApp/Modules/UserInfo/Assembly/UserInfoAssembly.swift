import UIKit
import FirebaseAuth

final class UserInfoAssembly {
    static func assemble(peerUser: User) -> UIViewController {
        let router = UserInfoRouter()
        let interactor = UserInfoInteractor()
        let presenter = UserInfoPresenter(router: router, interactor: interactor, user: peerUser)
        let view = UserInfoViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        return view
    }
}
