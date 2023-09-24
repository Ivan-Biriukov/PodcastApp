import UIKit

final class ExampleRouter {
    weak var view: UIViewController?
    
    func routeToMainTabBar() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        view?.navigationController?.present(tabBar, animated: true)
        //view?.present(tabBar, animated: true)
    }
}
