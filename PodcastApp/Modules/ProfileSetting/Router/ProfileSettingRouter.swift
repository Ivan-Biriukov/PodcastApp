//
//  ProfileSettingRouter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import UIKit

protocol ProfileSettingRouterInput {
    func routeTo()
}

final class ProfileSettingRouter {
    weak var view: UIViewController?
    
}

extension ProfileSettingRouter: ProfileSettingRouterInput {
    func routeTo() {
        let testView = UIViewController()
        testView.view.backgroundColor = .systemBlue
        view?.navigationController?.pushViewController(testView, animated: true)
    }
}
