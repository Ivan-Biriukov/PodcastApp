import UIKit
import SnapKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    static let reuseId = "HomeTableViewCell"
    
    private var isLiked: Bool = false {
        didSet {
            likeButton.setImage(isLiked ? .Home.activeLikeImage : .Home.likeImage, for: .normal)
        }
    }
    
    private var didTapLike: ((Bool) -> ())?
    
    private var urlString = ""
    
    // MARK: - UI Elements
    
    private lazy var bubbleView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .init(rgb: 0xEDF0FC)
        return view
    }()
    
    private let avatarImageView : UIImageView = {
        let avatar = UIImageView()
        avatar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 14.5).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 6.70).isActive = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 16
        avatar.backgroundColor = .init(rgb: 0x97D7F2)
        return avatar
    }()
    
    private lazy var likeButton : UIButton = {
        let buton = UIButton()
        buton.setImage(.Home.likeImage, for: .normal)
        buton.addTarget(self, action: #selector(didTapedLike), for: .touchUpInside)
        buton.contentMode = .scaleAspectFill
        return buton
    }()
    
    private lazy var mainTitleStack : UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.distribution = .equalSpacing
        st.alignment = .leading
        return st
    }()
    
    private lazy var topLabelsStack : UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fill
        st.spacing = 11
        st.alignment = .center
        return st
    }()
    
    private lazy var podcastNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .init(rgb: 0x423F51)
        lb.textAlignment = .left
        lb.text = "Ngobam"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var authorNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0x9997A5)
        lb.textAlignment = .left
        lb.text = "Kuy Entertainment"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var botLabelsStack : UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fill
        st.spacing = 11
        st.alignment = .center
        return st
    }()
    
    private lazy var podcastCategoryLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0x9997A5)
        lb.textAlignment = .left
        lb.text = "Life & Chill"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let doteViewSeporator : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.layer.cornerRadius = 2
        view.backgroundColor = .init(rgb: 0xC4C4C4)
        return view
    }()
    
    private lazy var episodsCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0x9997A5)
        lb.textAlignment = .left
        lb.text = "46 Eps"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Button Method
    
    @objc private func didTapedLike() {
        isLiked.toggle()
        didTapLike?(isLiked)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        podcastNameLabel.text = nil
        authorNameLabel.text = nil
        podcastCategoryLabel.text = nil
        episodsCountLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        contentView.addSubview(bubbleView)
        [avatarImageView, likeButton, mainTitleStack].forEach({bubbleView.addSubview($0)})
        [topLabelsStack, botLabelsStack].forEach({mainTitleStack.addArrangedSubview($0)})
        [podcastNameLabel, authorNameLabel].forEach({topLabelsStack.addArrangedSubview($0)})
        [podcastCategoryLabel, doteViewSeporator, episodsCountLabel].forEach({botLabelsStack.addArrangedSubview($0)})
    }
    
    private func setupConstraints() {
        bubbleView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).inset(8)
            make.leading.equalTo(contentView.snp.leading).inset(32)
            make.trailing.equalTo(contentView.snp.trailing).inset(32)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        avatarImageView.snp.makeConstraints{ make in
            make.centerY.equalTo(bubbleView.snp.centerY)
            make.leading.equalTo(bubbleView.snp.leading).inset(8)
        }
        
        likeButton.snp.makeConstraints{ make in
            make.centerY.equalTo(bubbleView.snp.centerY)
            make.size.equalTo(24)
            make.trailing.equalTo(bubbleView.snp.trailing).inset(8)
        }
        
        mainTitleStack.snp.makeConstraints{ make in
            make.top.equalTo(bubbleView.snp.top).inset(14)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-19)
            make.trailing.equalTo(likeButton.snp.leading)
            make.bottom.equalTo(bubbleView.snp.bottom).inset(15)
        }
    }
    
    func fill(viewModel: HomeViewCategoryTableViewModel) {
        urlString = viewModel.imageURLString
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: URL(string: urlString))
        podcastNameLabel.text = viewModel.podcastName
        authorNameLabel.text = viewModel.authorName
        podcastCategoryLabel.text = viewModel.podcastCategoryName
        episodsCountLabel.text = viewModel.episodsCount + " " + "Eps"
        isLiked = viewModel.savedToFavorits
        didTapLike = viewModel.didLike
    }
}

