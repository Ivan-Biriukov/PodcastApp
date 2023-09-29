import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "HomeCategoryesCell"
    
    // MARK: - UI Elements
    
    private lazy var itemImageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var bottomBubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.6)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var itemTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .bold)
        lb.textColor = .init(rgb: 0x423F51)
        lb.textAlignment = .left
        lb.text = "Music & Fun"
        return lb
    }()
    
    private lazy var podcastTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "84 Podcast"
        return lb
    }()
    
    private lazy var lablesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        [itemImageView, bottomBubbleView].forEach({contentView.addSubview($0)})
        bottomBubbleView.addSubview(lablesStack)
        [itemTitleLabel, podcastTitleLabel].forEach({lablesStack.addArrangedSubview($0)})
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .init(rgb: 0xFED9D6)
        
        bottomBubbleView.snp.makeConstraints{ make in
            make.leading.equalTo(self.contentView.snp.leading)
            make.trailing.equalTo(self.contentView.snp.trailing)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.height.equalTo(self.contentView.bounds.height / 3.125)
        }
        
        lablesStack.snp.makeConstraints{ make in
            make.leading.equalTo(bottomBubbleView.snp.leading).inset(14)
            make.trailing.equalTo(bottomBubbleView.snp.trailing).inset(14)
            make.top.equalTo(bottomBubbleView.snp.top).inset(14)
            make.bottom.equalTo(bottomBubbleView.snp.bottom).inset(14)
        }
    }
    
    func fill(viewModel: CategoryViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        itemTitleLabel.text = viewModel.genreTitle
        podcastTitleLabel.text = viewModel.podcastCount + " " + "Podcast"
    }
}
