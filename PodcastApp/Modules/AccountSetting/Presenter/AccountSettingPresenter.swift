//
//  AccountSettingPresenter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 28.09.2023.
//

import Foundation

final class AccountSettingPresenter {
    
    weak var view: AccountSettingViewInput?
    private let router: AccountSettingRouterInput
    
    init(router: AccountSettingRouterInput) {
        self.router = router
    }
}

extension AccountSettingPresenter: AccountSettingPresenterProtocol {
    
}
