import UIKit

final class ExampleAssembly {
    static func assemble() -> UIViewController {
        
        let router = ExampleRouter()
        let service = ExampleService()
        let presenter = ExamplePresenter(authService: service, router: router)
        let view = ExampleViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
