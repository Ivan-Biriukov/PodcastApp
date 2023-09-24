import Foundation

final class ExamplePresenter {
    
    weak var view: ExampleViewInput?
    private let authService: ExampleServiceProtocol
    private let router: ExampleRouter
    
    init(authService: ExampleServiceProtocol, router: ExampleRouter) {
        self.router = router
        self.authService = authService
    }
    
}

extension ExamplePresenter: ExamplePresenterProtocol {
    func viewDidLoad() {
        authService.createUser { [weak self] result in
            switch result {
            case .success:
                self?.router.routeToMainTabBar()
                let viewModels = self?.createViewModels(array: ["one, first"])
            case .failure:
                self?.view?.changeBackground()
            }
        }
    }
}

private extension ExamplePresenter {
    func createViewModels(array: [String]) -> [ExampleCellViewModel] {
        return array.map({ string -> ExampleCellViewModel in
                .init(title: string, subtitle: "subtitle") { [weak self] in
                    print("TAP")
                }
        })
    }
}
