import UIKit
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
    
    func routeToMainApp() {
        let mainTabBar = MainTabBarController()
        mainTabBar.modalTransitionStyle = .crossDissolve
        mainTabBar.modalPresentationStyle = .fullScreen
        view?.present(mainTabBar, animated: true)
    }
}
