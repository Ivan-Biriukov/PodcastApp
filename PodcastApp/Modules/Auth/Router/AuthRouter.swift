import UIKit
import FirebaseAuth
import ProgressHUD

final class AuthRouter {
    weak var view: UIViewController?
}

extension AuthRouter: AuthRouterInput {
    func showSuccess(with text: String) {
        ProgressHUD.showSuccess(text)
    }
    
    func showError(with error: String) {
        ProgressHUD.showError(error)
    }
    
    func routeToMainApp(user: RealmUserModel) {
        let mainTabBar = MainTabBarController()
        view?.navigationController?.modalPresentationStyle = .fullScreen
        view?.navigationController?.modalTransitionStyle = .crossDissolve
        view?.navigationController?.present(mainTabBar, animated: true)
    }
    
    func routeToContinueRegister(user: User) {
        let userInfoScreen = UserInfoAssembly.assemble(peerUser: user)
        view?.navigationController?.pushViewController(userInfoScreen, animated: true)
    }
}
