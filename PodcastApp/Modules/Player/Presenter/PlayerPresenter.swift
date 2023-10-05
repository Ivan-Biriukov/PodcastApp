//
//  PlayerPresenter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import Foundation

final class PlayerPresenter {
    
    weak var view: PlayerViewInput?
    private let router: PlayerRouterInput
    
    init(router: PlayerRouterInput) {
        self.router = router
    }
}

extension PlayerPresenter: PlayerPresenterProtocol {
    
}

private extension PlayerPresenter {
    
}
