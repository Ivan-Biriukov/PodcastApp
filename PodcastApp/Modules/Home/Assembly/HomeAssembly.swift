import UIKit

final class HomeAssembly {
    static func assemble() -> UIViewController {
        
        let router = HomeRouter()
        let presenter = HomePresenter(router: router)
        let view = HomeViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
