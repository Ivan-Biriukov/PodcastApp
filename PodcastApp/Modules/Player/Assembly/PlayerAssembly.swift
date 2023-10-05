//
//  PlayerAssembly.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit

final class PlayerAssembly {
    
    static func assemble() -> UIViewController {
        
        let router = PlayerRouter()
        let presenter = PlayerPresenter(router: router)
        let view = PlayerViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        return view
    }
}
