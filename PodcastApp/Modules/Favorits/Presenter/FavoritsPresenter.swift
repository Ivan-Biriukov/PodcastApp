import Foundation

final class FavoritsPresenter {
    
    weak var view: FavoritsViewInput?
    private let router: FavoritsRouterInput

    
    init(router: FavoritsRouterInput) {
        self.router = router
    }
}

extension FavoritsPresenter: FavoritsPresenterProtocol {
    func viewDidLoad() {
    }
}

private extension HomePresenter {
    
}
