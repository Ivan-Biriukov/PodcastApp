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
        
        network.fetchCategoriest(page: 2) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let genres = try JSONDecoder().decode(GenresModel.self, from: data)
                    print(genres.genres)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
            let secondVC = UIViewController()
            secondVC.view.backgroundColor = .systemOrange
            navController.pushViewController(secondVC, animated: true)
        case .settings:
            let settings = ProfileSettingAssembly.assemble()
            navController.pushViewController(settings, animated: true)
        }
        
        return navController
    }
}
