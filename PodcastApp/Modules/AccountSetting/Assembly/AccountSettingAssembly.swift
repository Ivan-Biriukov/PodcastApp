//
//  AccountSettingAssembly.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 28.09.2023.
//

import UIKit

final class AccountSettingAssembly {
    
    static func assemble() -> UIViewController {
        
        let router = AccountSettingRouter()
        let presenter = AccountSettingPresenter(router: router)
        let view = AccountSettingViewController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        return view
    }
    
}
