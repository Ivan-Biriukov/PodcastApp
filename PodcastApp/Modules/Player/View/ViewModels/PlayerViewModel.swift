//
//  PlayerViewModel.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 07.10.2023.
//

import Foundation

struct PlayerViewModel {
    let track: String
    let author: String
    let action: () -> ()
}
