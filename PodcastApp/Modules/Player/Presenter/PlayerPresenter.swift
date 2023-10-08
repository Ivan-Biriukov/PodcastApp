//
//  PlayerPresenter.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import Foundation

final class PlayerPresenter {
    
    weak var view: PlayerViewInput?
    private let router: PlayerRouterInput
    
    init(router: PlayerRouterInput) {
        self.router = router
    }
}

extension PlayerPresenter: PlayerPresenterProtocol {
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    func back() {
        print("back")
    }
    
    func addPlaylist() {
        print("addPlaylist")
    }
    
    func seek(to time: TimeInterval) {
        print("seek")
    }
    
    func shuffle() {
        print("shuffle")
    }
    
    func previous() {
        print("previous")
    }
    
    func play() {
        print("play")
    }
    
    func pause() {
        print("pause")
    }
    
    func next() {
        print("next")
    }
    
    func repeating() {
        print("repeating")
    }
}

private extension PlayerPresenter {
    
}
