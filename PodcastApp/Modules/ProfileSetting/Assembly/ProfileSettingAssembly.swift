//
//  ProfileSettingAssembly.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import UIKit

final class ProfileSettingAssembly {
    
    static func assemble() -> UIViewController {
        
        let router = ProfileSettingRouter()
        let presenter = ProfileSettingPresenter(router: router)
        let view = ProfileSettingViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        return view
    }
}
