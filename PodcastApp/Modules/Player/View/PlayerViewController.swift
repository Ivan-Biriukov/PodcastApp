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
            text: "44:30",
            font: .systemFont(ofSize: 14, weight: .regular),
            textColor: .init(rgb: 0x423F51),
            alignment: .center)
    }()
    
    private lazy var timeSlider: CustomSlider = {
        let slider = CustomSlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1200.0
        slider.value = 50
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
            text: "56:38",
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
    
    deinit {
        player?.removeTimeObserver(<#T##observer: Any##Any#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
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
        let seconds = Int(sender.value) % 60
        let minutes = Int(sender.value) / 60
        currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        let remainingTime = sender.maximumValue - sender.value
        let remainingSeconds = Int(remainingTime) % 60
        let remainingMinutes = Int(remainingTime) / 60
        endTimeLabel.text = String(format: "%02d:%02d", remainingMinutes, remainingSeconds)
    }
    
    @objc func shufflePressed() {
        presenter.shuffle()
    }
    
    @objc func previousPressed() {
        guard let duration  = player?.currentItem?.duration else {return}
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        let newTime = playerCurrentTime - 5
        if newTime < (CMTimeGetSeconds(duration) + 5) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    @objc func playPressed() {
        guard let url = urlLinks.first, player?.timeControlStatus != .playing else {
            player?.pause()
            return
        }
        player = AVPlayer(url: url)
        player?.play()
        
        let time = CMTime(value: 1, timescale: 1)
        let observer = player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { time in
            print("\(time)")
        })
    }
    
    @objc func nextPressed() {
        guard let duration  = player?.currentItem?.duration else {return}
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        let newTime = playerCurrentTime + 5
        if newTime < (CMTimeGetSeconds(duration) - 5) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
        
    }
    
    @objc func repeatPressed() {
        presenter.repeating()
    }
}
