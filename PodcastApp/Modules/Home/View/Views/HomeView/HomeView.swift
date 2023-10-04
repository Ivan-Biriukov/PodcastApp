import UIKit
import SnapKit

protocol HomeSeeAllDelegate: AnyObject {
    func seeAllTaped()
}

final class HomeView: UIView{
    
    // MARK: - Propertyes
    
    private let textDarkColor : UIColor = .init(rgb: 0x423F51)
    private let textLightColor : UIColor = .init(rgb: 0xA3A1AF)
    var categoryesViewModel = [CategoryViewModel]()
    var allCategoryesViewModel = [AllCategoryesViewModel]()
    var tableViewModel = [HomeViewCategoryTableViewModel]()
    weak var delegate: HomeSeeAllDelegate?
    
    
    // MARK: - UI Elements
    
    private lazy var nameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = textDarkColor
        lb.textAlignment = .left
        lb.text = "Abigael Amaniah"
        return lb
    }()
    
    private lazy var moodLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.textColor = textLightColor
        lb.textAlignment = .left
        lb.text = "Love,life and chill"
        return lb
    }()
    
    private lazy var avatarImageView : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 52).isActive = true
        img.widthAnchor.constraint(equalToConstant: 48).isActive = true
        img.backgroundColor = .init(rgb: 0xFCD3D2)
        img.layer.masksToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 12
        return img
    }()
    
    private lazy var titleLabelsStack : UIStackView = {
        let stac = UIStackView()
        stac.axis = .vertical
        stac.distribution = .fill
        stac.alignment = .leading
        stac.spacing = 6
        return stac
    }()
    
    private lazy var titleStack : UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .equalSpacing
        stac.alignment = .center
        return stac
    }()
    
    private lazy var categoryLabel : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = textDarkColor
        lb.textAlignment = .left
        lb.text = "Category"
        return lb
    }()
    
    private lazy var seeAllButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("See all", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        btn.setTitleColor(textLightColor, for: .normal)
        btn.addTarget(self, action: #selector(seeAllTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var categoryStack : UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .equalSpacing
        stac.alignment = .center
        return stac
    }()
    
    private let categoryCollecntion : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4.22).isActive = true
        collection.backgroundColor = .clear
        return collection
    }()
   
    private let categoryesNamesCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height /  18.0).isActive = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var tableView : UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.isUserInteractionEnabled = true
        tb.backgroundColor = .clear
        return tb
    }()
    
    // MARK: -  Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupCollections()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        [titleStack, categoryStack, categoryCollecntion, categoryesNamesCollection, tableView].forEach({self.addSubview($0)})
        [titleLabelsStack, avatarImageView].forEach({titleStack.addArrangedSubview($0)})
        [nameLabel, moodLabel].forEach({titleLabelsStack.addArrangedSubview($0)})
        [categoryLabel, seeAllButton].forEach({categoryStack.addArrangedSubview($0)})
    }
    
    private func setupConstraints() {
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        categoryStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(36)
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(28)
        }

        categoryCollecntion.snp.makeConstraints { make in
            make.top.equalTo(categoryStack.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        categoryesNamesCollection.snp.makeConstraints { make in
            make.top.equalTo(categoryCollecntion.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryesNamesCollection.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupCollections() {
        categoryCollecntion.delegate = self
        categoryCollecntion.dataSource = self
        categoryCollecntion.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId)
        
        categoryesNamesCollection.delegate = self
        categoryesNamesCollection.dataSource = self
        categoryesNamesCollection.register(CategoryesNamesCollectionViewCell.self, forCellWithReuseIdentifier: CategoryesNamesCollectionViewCell.reuseId)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseId)
    }
    
    func reloadViews() {
        categoryCollecntion.reloadData()
        categoryesNamesCollection.reloadData()
        tableView.reloadData()
    }
    
    // MARK: - Button Methods
    
    @objc func seeAllTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            sender.alpha = 1
        })
    }
}

// MARK: - CollectionView FlowLayout Delegate
extension HomeView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryesNamesCollection {
            let label = UILabel(frame: CGRect.zero)
            label.text = allCategoryesViewModel[indexPath.row].categoryName
                label.sizeToFit()
                return  CGSize(width: (label.frame.width+60), height: 44)
        } else {
            return CGSize(width: UIScreen.main.bounds.width / 2.60, height: UIScreen.main.bounds.height / 4.22)
        }
    }
}

// MARK: - Collection Delegates

extension HomeView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case categoryCollecntion:
            let viewModel = categoryesViewModel[indexPath.row]
            viewModel.action()
        default:
            for index in 0 ..< allCategoryesViewModel.count {
                if index != indexPath.row {
                    allCategoryesViewModel[index].isItemSelected = false
                }
            }
            
            let currentCellSelectedStatus = allCategoryesViewModel[indexPath.row].isItemSelected
            allCategoryesViewModel[indexPath.row].isItemSelected = !currentCellSelectedStatus
            
            let viewModel = allCategoryesViewModel[indexPath.row]
            viewModel.action()
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
}

// MARK: - Collection DataSource

extension HomeView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollecntion:
            return categoryesViewModel.count
        default:
            return allCategoryesViewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case categoryCollecntion:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.reuseId,
                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.fill(viewModel: categoryesViewModel[indexPath.row])
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryesNamesCollectionViewCell.reuseId,
                for: indexPath) as? CategoryesNamesCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.fill(viewModel: allCategoryesViewModel[indexPath.row])
            cell.getItemSelectedStatus(isChoosen: allCategoryesViewModel[indexPath.row].isItemSelected)
            return cell
        }
    }
}

// MARK: - Table Delegates

extension HomeView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = tableViewModel[indexPath.row]
        viewModel.action()
        
        let currentCell = tableViewModel[indexPath.row]
        tableViewModel[indexPath.row].savedToFavorits = !currentCell.savedToFavorits
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}

// MARK: - Table DataSource

extension HomeView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.reuseId,
            for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(viewModel: tableViewModel[indexPath.row])
        cell.updateButtonStatus(selected: tableViewModel[indexPath.row].savedToFavorits)
        return cell
    }
}
