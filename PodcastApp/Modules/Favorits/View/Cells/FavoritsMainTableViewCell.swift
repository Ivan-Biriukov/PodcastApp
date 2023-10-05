import UIKit
import SnapKit
import Kingfisher

class FavoritsMainTableViewCell: UITableViewCell {

    static let reuseId = "FavoritsMainTableCell"
    private var urlString = ""
    
    // MARK: - UI Elements
    
    private let iconImageView : UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 8
        avatar.backgroundColor = .init(rgb: 0xEDF0FC)
        return avatar
    }()
    
    private lazy var mainTitleStack : UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.distribution = .equalSpacing
        st.alignment = .leading
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
    
    private lazy var episodsCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0x9997A5)
        lb.textAlignment = .left
        lb.text = "46 Eps"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        selectionStyle = .none
        tintColor = .init(rgb: 0x413E50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        podcastNameLabel.text = nil
        episodsCountLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        [iconImageView, mainTitleStack].forEach({contentView.addSubview($0)})
        [podcastNameLabel, episodsCountLabel].forEach({mainTitleStack.addArrangedSubview($0)})
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.leading.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        mainTitleStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-12)
            make.trailing.equalToSuperview().inset(32)
        }
    }
    
    func fill(viewModel: FavoritsTableViewModel) {
        urlString = viewModel.imageURLString
        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(with: URL(string: urlString))
        podcastNameLabel.text = viewModel.titleText
        episodsCountLabel.text = viewModel.episodesString + " " + "Eps"
    }
    
    func setupFirstCell() {
        episodsCountLabel.removeFromSuperview()
        iconImageView.image = UIImage(named: "cellPlusIcon")
    }
}
