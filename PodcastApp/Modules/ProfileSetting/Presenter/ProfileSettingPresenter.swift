//
//  ProfileSettingPresenter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import Foundation

final class ProfileSettingPresenter {
    
    weak var view: ProfileSettingViewInput?
    private let router: ProfileSettingRouterInput
    
    init(router: ProfileSettingRouterInput) {
        self.router = router
    }
}

extension ProfileSettingPresenter: ProfileSettingPresenterProtocol {
    func viewDidLoad() {
        createViewModels()
    }
    
    func didTapLogOut() {
        print("log out")
    }
}

private extension ProfileSettingPresenter {
    func createViewModels() {
        let viewModels: [ProfileMainSettingsViewModel] = [
            .init(title: "Account Setting",
                  imageName: "profileImage", action: { [weak self] in
                      self?.router.routeToAccountSetting()
            }),
            .init(title: "Change Password",
                  imageName: "shieldImage", action: { [weak self] in
                      print("TAP")
            }),
            .init(title: "Forget Password",
                  imageName: "lockImage", action: { [weak self] in
                      print("TAP")
                  })
        ]
        
        DispatchQueue.main.async {
            self.view?.updateTable(viewModels: viewModels)
        }
    }
}
