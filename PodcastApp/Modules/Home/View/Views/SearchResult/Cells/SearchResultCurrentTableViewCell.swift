import UIKit
import Kingfisher

class SearchResultCurrentTableViewCell: UITableViewCell {
    
    static let reuseId = "SearchResultCurrentResultCell"
    private var imageUrlString = ""
    
    // MARK: - UI Elemetns
    
    private lazy var imageBuble : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 12
        img.backgroundColor = .init(rgb: 0xBCD8FB)
        img.heightAnchor.constraint(equalToConstant: 56).isActive = true
        img.widthAnchor.constraint(equalToConstant: 56).isActive = true
        return img
    }()

    private lazy var podcastNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = .init(rgb: 0x423F51)
        lb.textAlignment = .left
        lb.text = "Baby Pesut Podcast"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var podcastStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 7
        stack.alignment = .center
        return stack
    }()
 
    private lazy var episodsCountLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "56 Eps"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let separatorView : UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.backgroundColor = .init(rgb: 0xA3A1AF)
        return view
    }()
    
    private lazy var authorNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "Dr. Oi om jean"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageBuble.image = nil
        imageBuble.backgroundColor = .clear
        podcastNameLabel.text = nil
        episodsCountLabel.text = nil
        authorNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func setupUI() {
        selectionStyle = .none

        [imageBuble, podcastNameLabel, podcastStack].forEach({contentView.addSubview($0)})
        [episodsCountLabel, separatorView, authorNameLabel].forEach({podcastStack.addArrangedSubview($0)})
        
        imageBuble.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(2)
            make.leading.equalTo(contentView.snp.leading).inset(32)
        }
        
        podcastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(12)
            make.leading.equalTo(imageBuble.snp.trailing).inset(-12)
        }
        
        podcastStack.snp.makeConstraints {make in
            make.top.equalTo(podcastNameLabel.snp.bottom).inset(-5)
            make.leading.equalTo(imageBuble.snp.trailing).inset(-12)
        }
    }
    
    func fill(viewModel: SearchResultViewModel) {
        imageUrlString = viewModel.imageURLString
        imageBuble.kf.setImage(with: URL(string: imageUrlString))
        podcastNameLabel.text = viewModel.podcastGroupName
        episodsCountLabel.text = viewModel.episodsCount + " " + "Eps"
        authorNameLabel.text = viewModel.authorName
    }

}
