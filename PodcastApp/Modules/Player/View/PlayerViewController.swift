//
//  PlayerViewController.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 04.10.2023.
//

import UIKit
import SnapKit
import AVFoundation

final class PlayerViewController: BaseViewController {
    
    // MARK: - Properties
    private var player : AVPlayer?
    var playerItem: AVPlayerItem!

    private let presenter: PlayerPresenterProtocol
    private var links : [String]
    private var urlLinks: [URL] {
        links.compactMap { URL(string: $0) }
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nowPlayingLabel: UILabel = {
        return createLabel(
            text: "Now playing",
            font: .systemFont(ofSize: 16, weight: .bold),
            textColor: .init(rgb: 0x423F51),
            alignment: .center)
    }()
    
    private lazy var addPlaylistButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "addPlaylist"), for: .normal)
        button.addTarget(self, action: #selector(addPlaylistPressed), for: .touchUpInside)
        return button
    }()
    
    private let collectionview: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .init(rgb: 0xAEE2F3)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var trackLabel: UILabel = {
        return createLabel(
            text: "Baby Pesut Eps 56",
            font: .systemFont(ofSize: 16, weight: .bold),
            textColor: .init(rgb: 0x423F51),
            alignment: .center)
    }()
    
    private lazy var authorLabel: UILabel = {
        return createLabel(
            text: "Dr. Oi om jean",
            font: .systemFont(ofSize: 14, weight: .regular),
            textColor: .init(rgb: 0xA3A1AF),
            alignment: .center)
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        return createLabel(
            text: "",
            font: .systemFont(ofSize: 14, weight: .regular),
            textColor: .init(rgb: 0x423F51),
            alignment: .center)
    }()
    
    private lazy var timeSlider: CustomSlider = {
        let slider = CustomSlider()
        slider.minimumTrackTintColor = .init(rgb: 0x2882F1)
        slider.maximumTrackTintColor = .init(rgb: 0x2882F1)
        slider.thumbTintColor = .init(rgb: 0x2882F1)
        let configuration = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
        slider.addTarget(self, action: #selector(timeSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var endTimeLabel: UILabel = {
        return createLabel(
            text: "",
            font: .systemFont(ofSize: 14, weight: .regular),
            textColor: .init(rgb: 0x423F51),
            alignment: .center)
    }()
    
    private lazy var trackView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var shuffleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "shuffleImage"), for: .normal)
        button.addTarget(self, action: #selector(shufflePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "previousImage"), for: .normal)
        button.addTarget(self, action: #selector(previousPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "playImage"), for: .normal)
        button.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "nextImage"), for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "repeatImage"), for: .normal)
        button.addTarget(self, action: #selector(repeatPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var controlView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var isPlaying: Bool = false {
        didSet {
            playButton.setImage(UIImage(named: isPlaying ? "pauseImage" : "playImage"), for: .normal)
        }
    }
    
    
    // MARK: - Init
    init(presenter: PlayerPresenterProtocol, links : [String]) {
        self.presenter = presenter
        self.links = links
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        guard let url = urlLinks.first else { return }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playPressed()
    }
}

extension PlayerViewController: PlayerViewInput {
    func updateNowPlaying(viewModels: [PlayerViewModel]) {
        
    }
    
}

// MARK: - Extensions
private extension PlayerViewController {
    
    func addSubviews() {
        trackView.addSubview(currentTimeLabel)
        trackView.addSubview(timeSlider)
        trackView.addSubview(endTimeLabel)
        
        controlView.addSubview(shuffleButton)
        controlView.addSubview(previousButton)
        controlView.addSubview(playButton)
        controlView.addSubview(nextButton)
        controlView.addSubview(repeatButton)
        
        addSubviews(views: backButton, nowPlayingLabel, addPlaylistButton, collectionview, trackLabel, authorLabel, trackView, controlView)
    }
    
    func makeConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(56)
            make.leading.equalToSuperview().inset(32)
            make.height.width.equalTo(24)
        }
        
        nowPlayingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        addPlaylistButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.trailing.equalToSuperview().inset(32)
            make.height.width.equalTo(20)
        }
        
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(nowPlayingLabel.snp.bottom).offset(49)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(326)
        }
        
        trackLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionview.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(22)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(trackLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(19)
        }
        
        trackView.snp.makeConstraints { make in
            make.top.equalTo(trackLabel.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(19)
        }
        
        currentTimeLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(40)
        }
        
        timeSlider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(currentTimeLabel.snp.trailing).offset(7)
            make.height.equalTo(5)
        }
        
        endTimeLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(timeSlider.snp.trailing).offset(7)
            make.width.equalTo(40)
        }
        
        controlView.snp.makeConstraints { make in
            make.top.equalTo(trackView.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(64)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        previousButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(shuffleButton.snp.trailing).offset(32)
            make.height.width.equalTo(16)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(previousButton.snp.trailing).offset(32)
            make.height.width.equalTo(64)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(playButton.snp.trailing).offset(32)
            make.height.width.equalTo(16)
        }
        
        repeatButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.width.equalTo(16)
        }
    }
}

// MARK: - Target Actions
extension PlayerViewController {
    
    @objc func backPressed() {
        presenter.back()
        self.dismiss(animated: true)
    }
    
    @objc func addPlaylistPressed() {
        presenter.addPlaylist()
    }
    
    @objc func timeSliderChanged(sender: UISlider) {
        let duration = CMTimeGetSeconds(playerItem.duration)
        let currentTime = duration * Double(sender.value)
        player?.seek(to: CMTime(seconds: currentTime, preferredTimescale: 1))
    }
    
    @objc func shufflePressed() {
        presenter.shuffle()
    }
    
    @objc func previousPressed() {
        let timeToAdd = CMTime(seconds: -5, preferredTimescale: 1)
        guard let currentTime = player?.currentTime() else { return }
        let newTime = CMTimeAdd(currentTime, timeToAdd)
        player?.seek(to: newTime)
    }
    
    @objc func playPressed() {
        isPlaying = !isPlaying
        if player?.timeControlStatus == .playing {
            player?.pause()
        } else {
            player?.play()
        }
        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            
            let currentTime = CMTimeGetSeconds(time)
            let duration = CMTimeGetSeconds(self.playerItem.duration)
            let remainingTime = duration - currentTime
            
            self.currentTimeLabel.text = self.formatTime(currentTime)
            self.endTimeLabel.text = self.formatTime(remainingTime)
            self.timeSlider.value = Float(currentTime / duration)
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func nextPressed() {
        let timeToAdd = CMTime(seconds: 5, preferredTimescale: 1)
        guard let currentTime = player?.currentTime() else { return }
        let newTime = CMTimeAdd(currentTime, timeToAdd)
        player?.seek(to: newTime)
    }
    
    @objc func repeatPressed() {
        presenter.repeating()
    }
}
