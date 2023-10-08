import UIKit
import Kingfisher

class AllResultsTableViewCell: UITableViewCell {
    
    static let reuseId = "SearchResultAllResultsCell"
    private var imageUrlString = ""

    // MARK: - UI Elements
    
    private lazy var bubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = .init(rgb: 0xEDF0FC)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let iconImageView : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.heightAnchor.constraint(equalToConstant: 56).isActive = true
        view.widthAnchor.constraint(equalToConstant: 56).isActive = true
        view.backgroundColor = .init(rgb: 0xCCE1FB)
        return view
    }()
    
    private lazy var podcastNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .init(rgb: 0x413E50)
        lb.textAlignment = .left
        lb.text = "Between love and career"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var countsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 6
        stack.alignment = .center
        return stack
    }()
 
    private lazy var durationLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "56:38"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let separatorView : UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.backgroundColor = .init(rgb: 0xA3A1AF)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var episodsCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "55 Eps"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        podcastNameLabel.text = nil
        durationLabel.text = nil
        episodsCountLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        selectionStyle = .none
        contentView.addSubview(bubbleView)
        [iconImageView, podcastNameLabel, countsStack].forEach({bubbleView.addSubview($0)})
        [durationLabel, separatorView, episodsCountLabel].forEach({countsStack.addArrangedSubview($0)})
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(8)
            make.leading.equalTo(contentView.snp.leading).inset(32)
            make.trailing.equalTo(contentView.snp.trailing).inset(32)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(bubbleView.snp.centerY)
            make.leading.equalTo(bubbleView.snp.leading).inset(8)
        }
        
        podcastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(bubbleView.snp.top).inset(15)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-19)
            make.trailing.equalToSuperview()
        }
        
        countsStack.snp.makeConstraints { make in
            make.top.equalTo(podcastNameLabel.snp.bottom).inset(-6)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-19)
        }
    }
    
    func fill(viewModel: SearchResultAllPodcastsViewModel) {
        imageUrlString = viewModel.imageURLString
        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(with: URL(string: imageUrlString))
        podcastNameLabel.text = viewModel.podcastName
        durationLabel.text = viewModel.trackDuration
        episodsCountLabel.text = viewModel.episodeNumber
    }
}
