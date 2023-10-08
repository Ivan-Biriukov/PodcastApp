//
//  ProfileSettingViewInput.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import Foundation

protocol ProfileSettingViewInput: AnyObject {
    func updateTable(viewModels: [ProfileMainSettingsViewModel])
}
