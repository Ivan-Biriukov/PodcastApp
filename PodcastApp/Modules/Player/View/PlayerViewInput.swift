//
//  PlayerViewInput.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import Foundation

protocol PlayerViewInput: AnyObject {
    func updateNowPlaying(viewModels: [PlayerViewModel])
}
