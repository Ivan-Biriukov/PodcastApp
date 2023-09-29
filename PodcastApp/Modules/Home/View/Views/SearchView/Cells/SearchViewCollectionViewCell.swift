import UIKit
import SnapKit

class SearchViewCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "SearchViewCollectionCell"
    
    // MARK: - UI Elements
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Music and chill"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: -  Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .init(rgb: 0xBCD8FB)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func fill(viewModel: AllCategoryesViewModel) {
        titleLabel.text = viewModel.categoryName
    }
}
