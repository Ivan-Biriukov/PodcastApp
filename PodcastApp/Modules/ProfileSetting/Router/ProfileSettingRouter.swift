//
//  ProfileSettingRouter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import UIKit

protocol ProfileSettingRouterInput {
    func routeToAccountSetting()
}

final class ProfileSettingRouter {
    weak var view: UIViewController?
    
}

extension ProfileSettingRouter: ProfileSettingRouterInput {
    func routeToAccountSetting() {
        let accountSettings = AccountSettingAssembly.assemble()
        accountSettings.modalPresentationStyle = .fullScreen
        accountSettings.modalTransitionStyle = .crossDissolve
        self.view?.present(accountSettings, animated: true)
    }
}
