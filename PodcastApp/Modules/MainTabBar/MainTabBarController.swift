import UIKit

fileprivate enum TabBarPage {
    case favorites
    case home
    case settings
    
    var pageIndex: Int {
        switch self {
        case .favorites:
            0
        case .home:
            1
        case .settings:
            2
        }
    }
    
    var pageImage: UIImage? {
        switch self {
        case .favorites:
            return UIImage.TabBarImage.boockMarkIcon
        case .home:
            return UIImage.TabBarImage.homeIcon
        case .settings:
            return UIImage.TabBarImage.settingsIcon
        }
    }
    
    var selectedPageImage: UIImage? {
        switch self {
        case .favorites:
            return UIImage.TabBarImage.selectedBoockMarkIcon
        case .home:
            return UIImage.TabBarImage.selectedHomeIcon
        case .settings:
            return UIImage.TabBarImage.selectedSettingsIcon
        }
    }
    
    var pageTitle: String {
        switch self {
        case .favorites:
            "Favorites"
        case .home:
            "Home"
        case .settings:
            "Settings"
        }
    }
}

final class MainTabBarController: UITabBarController {
    
    private let pages: [TabBarPage] = [
        .favorites, .home, .settings
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarModules()
    }
}

private extension MainTabBarController {
    func configureTabBarModules() {
        let controllers: [UIViewController] = pages
            .sorted(by: { $0.pageIndex < $1.pageIndex })
            .map({ getTabController($0) })
        
        self.setViewControllers(controllers, animated: true)
        self.selectedIndex = 1
    }
    
    func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        
        navController.tabBarItem = .init(
            title: page.pageTitle, image: page.pageImage, selectedImage: page.selectedPageImage
        )
    
        switch page {
        case .favorites:
            let firstVC = UIViewController()
            firstVC.view.backgroundColor = .systemRed
            navController.pushViewController(firstVC, animated: true)
        case .home:
            let firstVC = UIViewController()
            firstVC.view.backgroundColor = .systemOrange
            navController.pushViewController(firstVC, animated: true)
        case .settings:
            let firstVC = UIViewController()
            firstVC.view.backgroundColor = .systemYellow
            navController.pushViewController(firstVC, animated: true)
        }
        
        return navController
    }
}
