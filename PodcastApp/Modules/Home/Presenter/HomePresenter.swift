import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    
    init(router: HomeRouterInput) {
        self.router = router
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
}

private extension HomePresenter {
    
}
