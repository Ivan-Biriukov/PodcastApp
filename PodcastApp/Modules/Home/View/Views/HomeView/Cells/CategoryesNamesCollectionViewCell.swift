import UIKit
import SnapKit

class CategoryesNamesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "HomeCategoryesNamesCell"
    
    // MARK: - UI Elements
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = .init(rgb: 0x423F51)
        lb.textAlignment = .center
        lb.text = "Popular"
        return lb
    }()
    
    private let fireImageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = .Home.fireImage
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return img
    }()
    
    // MARK: - Init
    
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
        [fireImageView, titleLabel].forEach({contentView.addSubview($0)})
        contentView.layer.cornerRadius = 12
        
        fireImageView.snp.makeConstraints{make in
            make.leading.equalTo(self.contentView.snp.leading).inset(16)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints{make in
            make.leading.equalTo(fireImageView.snp.trailing).inset(-12)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
    
    func changeUIForSelected() {
        fireImageView.isHidden = false
        contentView.backgroundColor = .init(rgb: 0xE5E5E5)
    }
    
    func resotreUIForUnselected() {
        fireImageView.isHidden = true
        contentView.backgroundColor = .clear
    }
    
    func fill(viewModel: AllCategoryesViewModel) {
        titleLabel.text = viewModel.categoryName
    }
}
