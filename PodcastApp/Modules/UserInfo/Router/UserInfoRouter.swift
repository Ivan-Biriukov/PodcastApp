import UIKit

final class UserInfoRouter {
    weak var view: UIViewController?
    
    func routeToMainApp(user: RealmUserModel) {
        let mainApp = MainTabBarController()
        view?.navigationController?.modalPresentationStyle = .fullScreen
        view?.navigationController?.modalTransitionStyle = .crossDissolve
        view?.navigationController?.present(mainApp, animated: true)
    }
}
