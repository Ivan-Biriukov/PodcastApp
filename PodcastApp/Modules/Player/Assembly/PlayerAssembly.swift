//
//  PlayerAssembly.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit

final class PlayerAssembly {
    
    static func assemble(links : [String]) -> UIViewController {
        
        let router = PlayerRouter()
        let presenter = PlayerPresenter(router: router)
        let view = PlayerViewController(presenter: presenter, links: links)
        
        router.view = view
        presenter.view = view
        return view
    }
}
