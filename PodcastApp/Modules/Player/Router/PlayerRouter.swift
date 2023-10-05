//
//  PlayerRouter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit

protocol PlayerRouterInput {
}

final class PlayerRouter {
    weak var view: UIViewController?
}

extension PlayerRouter: PlayerRouterInput {
}
