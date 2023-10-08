//
//  PlayerAssembly.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit

final class PlayerAssembly {
    
    static func assemble(links : [String], track: String, author: String) -> UIViewController {
        
        let router = PlayerRouter()
        let presenter = PlayerPresenter(router: router)
        let view = PlayerViewController(presenter: presenter, links: links, track: track, author: author)
        
        router.view = view
        presenter.view = view
        return view
    }
}
