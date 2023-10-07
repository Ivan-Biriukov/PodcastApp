//
//  PlayerPresenterProtocol.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import Foundation

protocol PlayerPresenterProtocol {
    func viewDidLoad()
    func back()
    func addPlaylist()
    func seek(to time: TimeInterval)
    func shuffle()
    func previous()
    func play()
    func pause()
    func next()
    func repeating()
}
