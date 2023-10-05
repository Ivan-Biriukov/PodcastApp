import UIKit
import SnapKit

extension FavoritsViewController {
    struct Constants {
        let textBlackColor : UIColor = .init(rgb: 0x423F51)
        let lightTextColor : UIColor = .init(rgb: 0xA3A1AF)
    }
}

class FavoritsViewController: BaseViewController {
    
    // MARK: - Propertyes
    
    private let presenter: FavoritsPresenterProtocol
    private let constants: Constants
    private var favoritsViewModels = [FavoritsMainPlaylistViewModel]()
    
    
    // MARK: - UI Elements
    
    private lazy var titleLabel : UILabel = {
        return createLabel(text: "Favorites & Playlist", font: .systemFont(ofSize: 16, weight: .bold), textColor: constants.textBlackColor)
    }()
    
    private lazy var threeDotsButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(.Main.threeDotsImage, for: .normal)
        btn.tintColor = constants.textBlackColor
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(dotesButtonTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleStack : UIStackView = {
        let stack = createStackView(for: titleLabel, threeDotsButton, axis: .horizontal, spacing: 0)
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var favoritsTitle : UILabel = {
        return createLabel(text: "Favorites", font: .systemFont(ofSize: 16, weight: .bold), textColor: constants.textBlackColor)
    }()
    
    private lazy var seeAllButton : UIButton = {
        let btn = createTitleButton(title: "See all", titleColor: constants.lightTextColor, font: .systemFont(ofSize: 16, weight: .regular))
        btn.addTarget(self, action: #selector(seeAllTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var favoritsTitleStack : UIStackView = {
        let stack = createStackView(for: favoritsTitle,seeAllButton , axis: .horizontal, spacing: 0)
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let favoritsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 120, height: 160)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var playListLabel : UILabel = {
        return createLabel(text: "Your Playlist", font: .systemFont(ofSize: 16, weight: .bold), textColor: constants.textBlackColor)
    }()
    
    private lazy var playlistTableView : UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        return tb
    }()
    
    
    // MARK: - LifeCycleMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupCollections()

    }
    
    // MARK: - Init
    
    init(presenter: FavoritsPresenterProtocol) {
        self.presenter = presenter
        self.constants = Constants()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritsViewController : FavoritsViewInput {
    
}

// MARK: - SetUP UI

private extension FavoritsViewController {
    
    func addSubviews() {
        addSubviews(views: titleStack, favoritsTitleStack, favoritsCollection, playListLabel, playlistTableView)
    }
    
    func setupConstraints() {
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.trailing.equalToSuperview().inset(32)
            make.leading.equalToSuperview().inset(120)
        }
        
        threeDotsButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(4)
        }
        
        favoritsTitleStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).inset(-33)
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(28)
        }
        
        favoritsCollection.snp.makeConstraints { make in
            make.top.equalTo(favoritsTitleStack.snp.bottom).inset(-13)
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        playListLabel.snp.makeConstraints { make in
            make.top.equalTo(favoritsCollection.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(32)
        }
        
        playlistTableView.snp.makeConstraints { make in
            make.top.equalTo(playListLabel.snp.bottom).inset(-13)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupCollections() {
        favoritsCollection.delegate = self
        favoritsCollection.dataSource = self
        favoritsCollection.register(FavoritsCollectionViewCell.self, forCellWithReuseIdentifier: FavoritsCollectionViewCell.reuseId)
    }
    
    func setupTableView() {
        
    }
}

// MARK: - Buttons Methods

private extension FavoritsViewController {
    
    @objc func dotesButtonTaped(_ sender: UIButton) {
        
    }
    
    @objc func seeAllTaped(_ sender: UIButton) {
        
    }
}

// MARK: - TableView Delegate

extension FavoritsViewController: UITableViewDelegate {
    
}

// MARK: - TableView DataSource

extension FavoritsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

// MARK: - CollectionView Delegate

extension FavoritsViewController: UICollectionViewDelegate {
    
}

// MARK: - CollectionView DataSource

extension FavoritsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoritsViewModels.count == 0 {
            return 1
        } else {
            return favoritsViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritsCollectionViewCell.reuseId, for: indexPath) as? FavoritsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if favoritsViewModels.count == 0 {
            let emptyData = FavoritsMainPlaylistViewModel(imageURLString: "", nameText: "Oops, Your", authorText: "Favorits - empty", id: 0)
            cell.fill(viewModel: emptyData)
        } else {
            cell.fill(viewModel: favoritsViewModels[indexPath.row])

        }
        return cell
    }
}
