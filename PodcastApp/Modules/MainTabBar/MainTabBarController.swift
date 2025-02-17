import UIKit

fileprivate enum TabBarPage {
    case favorites
    case home
    case settings
    
    var pageIndex: Int {
        switch self {
        case .favorites:
            return 0
        case .home:
            return 1
        case .settings:
            return 2
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
            return "Favorites"
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }
}

final class MainTabBarController: UITabBarController {
    private let network: NetworkManagerProtocol = NetworkManager()
    
    private let pages: [TabBarPage] = [
        .favorites, .home, .settings
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarModules()
        setTabBarAppearance()
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
            let firstVC = FavoritsAssembly.assemble()
            navController.pushViewController(firstVC, animated: true)
        case .home:
            let home = HomeAssembly.assemble()
            navController.pushViewController(home, animated: true)
        case .settings:
            let settings = ProfileSettingAssembly.assemble()
            navController.pushViewController(settings, animated: true)
        }
        
        return navController
    }
    
    func setTabBarAppearance() {
        let positionX: CGFloat = 25
        let positionY: CGFloat = 15
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY * 1.2, width: width, height: height), cornerRadius: height / 3.5)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .fill
        
        roundLayer.fillColor = UIColor.tabBarMain.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarNotChosen
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.075
        tabBar.layer.shadowOffset = .init(width: 2.5, height: 2.5)
        tabBar.layer.shadowRadius = 10
    }
}
