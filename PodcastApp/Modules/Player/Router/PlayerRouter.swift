//
//  PlayerRouter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit

protocol PlayerRouterInput {
    func routeToPlayerVC()
}

final class PlayerRouter {
    weak var view: UIViewController?
}

extension PlayerRouter: PlayerRouterInput {
    func routeToPlayerVC() {
        let playerVC = PlayerAssembly.assemble()
        playerVC.modalPresentationStyle = .fullScreen
        playerVC.modalTransitionStyle = .crossDissolve
        self.view?.present(playerVC, animated: true)
    }
    
}
