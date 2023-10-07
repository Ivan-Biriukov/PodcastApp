import Foundation

final class PlayerService {
    private let router: PlayerRouterInput
    
    init(router: PlayerRouterInput) {
        self.router = router
    }
}

extension PlayerService: PlayerServiceProtocol {
    func openPlayer(with podcast: Podcast) {
        router.routeToPlayerVC()
    }
}
