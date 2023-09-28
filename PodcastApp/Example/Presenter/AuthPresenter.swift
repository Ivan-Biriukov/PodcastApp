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
    func viewDidLoad() { }
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
