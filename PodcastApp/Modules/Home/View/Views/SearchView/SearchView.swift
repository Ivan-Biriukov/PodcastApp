import UIKit
import SnapKit

protocol SearchSeeAllDelegate: AnyObject {
    func searchSeeAllTaped()
}

final class SearchView: UIView {
    
    // MARK: - Propertyes
    
    private let textDarkColor : UIColor = .init(rgb: 0x423F51)
    private let textLightColor : UIColor = .init(rgb: 0xA3A1AF)
    
    var topGenresViewModel = [AllCategoryesViewModel]()
    var allGenresViewModel = [AllCategoryesViewModel]()
    weak var delegate : SearchSeeAllDelegate?
    
    // MARK: - UI Elements
    
    private lazy var searchFieldButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.Main.searchImage, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.contentMode = .scaleToFill
        btn.tintColor = textLightColor
        btn.addTarget(self, action: #selector(searchTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let searchField : UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.layer.cornerRadius = 12
        field.attributedPlaceholder = NSAttributedString(string: "Podcast, channel, or artists", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(rgb: 0xA3A1AF), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.textColor = .init(rgb: 0x423F51)
        field.clearButtonMode = .never
        field.rightViewMode = .always
        field.setLeftPaddingPoints(24)
        return field
    }()
    
    private lazy var genreStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 64).isActive = true
        return stack
    }()
    
    private lazy var genreLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = textDarkColor
        lb.textAlignment = .center
        lb.text = "Top Genres"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var seeAllButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("See all", for: .normal)
        btn.setTitleColor(textLightColor, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        btn.addTarget(self, action: #selector(seeAllTaped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var topGenresCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.55, height: UIScreen.main.bounds.height / 9.66)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 9.0).isActive = true
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var allGenresLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = textDarkColor
        lb.textAlignment = .center
        lb.text = "Browse all"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var allGenresCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.55, height: UIScreen.main.bounds.height / 9.66)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 64).isActive = true
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        configureSearchBar()
        configureCollections()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Buttons Methods
    
    @objc func searchTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        let vcToPresent = SearchResultsViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            sender.alpha = 1
            self.window?.rootViewController?.present(vcToPresent, animated: true, completion: nil)
        })
    }
    
    @objc func seeAllTaped (_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            sender.alpha = 1
            self.delegate?.searchSeeAllTaped()
        })
    }
    
    // MARK: - Configure
    
    private func addSubviews() {
        [searchField, genreStack, topGenresCollection, allGenresLabel, allGenresCollection].forEach({self.addSubview($0)})
        [genreLabel, seeAllButton].forEach({genreStack.addArrangedSubview($0)})
    }
    
    private func setupConstraints() {
        searchField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(48)
            make.width.equalTo(UIScreen.main.bounds.width - 64)
        }
        
        genreStack.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).inset(-35)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        topGenresCollection.snp.makeConstraints { make in
            make.top.equalTo(genreStack.snp.bottom).inset(-13)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.leading.equalTo(self.snp.leading).inset(20)
        }
        
        allGenresLabel.snp.makeConstraints { make in
            make.top.equalTo(topGenresCollection.snp.bottom).inset(-24)
            make.leading.equalTo(self.snp.leading).inset(32)
        }
        
        allGenresCollection.snp.makeConstraints { make in
            make.top.equalTo(allGenresLabel.snp.bottom).inset(-21)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureSearchBar() {
        searchField.delegate = self
        
        let separateView = UIView()
        separateView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let rightViewStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [searchFieldButton, separateView])
            return stack
        }()
        searchField.rightView = rightViewStack
    }
    
    private func configureCollections() {
        topGenresCollection.delegate = self
        topGenresCollection.dataSource = self
        topGenresCollection.register(SearchViewCollectionViewCell.self, forCellWithReuseIdentifier: SearchViewCollectionViewCell.reuseId)
        
        allGenresCollection.delegate = self
        allGenresCollection.dataSource = self
        allGenresCollection.register(SearchViewCollectionViewCell.self, forCellWithReuseIdentifier: SearchViewCollectionViewCell.reuseId)
    }
    
    func reloadCollections() {
        topGenresCollection.reloadData()
        allGenresCollection.reloadData()
    }
}

// MARK: - TextField Delegate

extension SearchView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Collection Delegate

extension SearchView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case topGenresCollection:
            let viewModel = topGenresViewModel[indexPath.row]
            viewModel.action()
        default:
            let viewModel = allGenresViewModel[indexPath.row]
            viewModel.action()
        }
    }
}

// MARK: - Collection DataSource

extension SearchView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topGenresCollection {
            return topGenresViewModel.count
        } else {
            return allGenresViewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchViewCollectionViewCell.reuseId,
            for: indexPath) as? SearchViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch collectionView {
        case topGenresCollection:
            cell.fill(viewModel: topGenresViewModel[indexPath.row])
        default:
            cell.fill(viewModel: allGenresViewModel[indexPath.row])
        }
        return cell
    }
}

