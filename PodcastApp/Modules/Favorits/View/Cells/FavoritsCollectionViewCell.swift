import UIKit
import SnapKit
import Kingfisher

class FavoritsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "FavoritsCollectionCell"
    private var imageURLString : String = ""
    
    // MARK: - UI Elements
    
    private lazy var itemImageView : UIImageView = {
        let image = UIImageView()
        //image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.backgroundColor = .init(rgb: 0xD9D9D9)
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var nameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .init(rgb: 0x413E50)
        lb.textAlignment = .center
        lb.numberOfLines = 2
        return lb
    }()
    
    private lazy var authorLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0x858391)
        lb.textAlignment = .center
        lb.numberOfLines = 2
        return lb
    }()
    
    private lazy var titleStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 6
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        imageURLString = ""
        nameLabel.text = nil
        authorLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        [itemImageView, titleStack].forEach({contentView.addSubview($0)})
        [nameLabel, authorLabel].forEach({titleStack.addArrangedSubview($0)})
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .init(rgb: 0xE6F6FF)
        
        itemImageView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview().inset(26)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).inset(-12)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func fill(viewModel: FavoritsMainPlaylistViewModel) {
        imageURLString = viewModel.imageURLString
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(with: URL(string: imageURLString))
        nameLabel.text = viewModel.nameText
        authorLabel.text = viewModel.authorText
    }
}
