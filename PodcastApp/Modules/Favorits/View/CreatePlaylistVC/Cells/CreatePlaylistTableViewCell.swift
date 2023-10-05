import UIKit
import SnapKit

class CreatePlaylistTableViewCell: UITableViewCell {

    static let reuseId = "PlaylistableViewCell"
    private var isItemAdded : Bool = false
    private var urlString = ""
    
    // MARK: - UI Elements
    
    private lazy var bubbleView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .init(rgb: 0xEDF0FC)
        return view
    }()
    
    private let itemImageView : UIImageView = {
        let item = UIImageView()
        item.contentMode = .scaleAspectFill
        item.layer.masksToBounds = true
        item.layer.cornerRadius = 16
        item.backgroundColor = .init(rgb: 0xB9E6E9)
        return item
    }()
    
    private lazy var addButton : UIButton = {
        let buton = UIButton()
        buton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        buton.addTarget(self, action: #selector(didTapedLike(_:)), for: .touchUpInside)
        buton.contentMode = .scaleAspectFill
        buton.tintColor = .init(rgb: 0x413E50)
        return buton
    }()
    
    private lazy var mainTitleStack : UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.distribution = .equalSpacing
        st.alignment = .leading
        return st
    }()
    
    private lazy var playlistName : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .init(rgb: 0x413E50)
        lb.textAlignment = .left
        lb.text = "Roar and move"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var botLabelsStack : UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fill
        st.spacing = 7
        st.alignment = .center
        return st
    }()
    
    private lazy var podcastCategoryLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .regular)
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "Test data"
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
        lb.textColor = .init(rgb: 0xA3A1AF)
        lb.textAlignment = .left
        lb.text = "1:40:40"
        return lb
    }()
    
    // MARK: - Button Method
    
    @objc private func didTapedLike(_ sender: UIButton) {
        updateButtonStatus(selected: isItemAdded)
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
        itemImageView.image = nil
        playlistName.text = nil
        podcastCategoryLabel.text = nil
        episodsCountLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        contentView.addSubview(bubbleView)
        [itemImageView, mainTitleStack, addButton].forEach({bubbleView.addSubview($0)})
        [playlistName, botLabelsStack].forEach({mainTitleStack.addArrangedSubview($0)})
        [podcastCategoryLabel, doteViewSeporator, episodsCountLabel].forEach({botLabelsStack.addArrangedSubview($0)})
    }
    
    private func setupConstraints() {
        bubbleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.top.leading.equalToSuperview().inset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(24)
        }
        
        mainTitleStack.snp.makeConstraints { make in
            make.leading.equalTo(itemImageView.snp.trailing).inset(-19)
            make.trailing.equalTo(addButton.snp.leading).inset(-4)
            make.top.bottom.equalToSuperview().inset(14)
        }
    }
    
    func fill(viewModel: PlaylistTableViewModel) {
        itemImageView.image = viewModel.image
        playlistName.text = viewModel.listName
        podcastCategoryLabel.text = viewModel.authorName
        episodsCountLabel.text = viewModel.duration
    }
    
    func updateButtonStatus(selected: Bool) {
        if selected {
            addButton.setImage(.Main.selectedPlusIcon, for: .normal)
        } else {
            addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        }
    }
}
