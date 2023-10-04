import UIKit

final class FavoritsAssembly {
    static func assemble() -> UIViewController {
        
        let router = FavoritsRouter()
        let presenter = FavoritsPresenter(router: router)
        let view = FavoritsViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
