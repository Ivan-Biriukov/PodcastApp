import UIKit
import SnapKit

extension HomeViewController {
    struct Constants {
        let titleLabelFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        
        let titleColor: UIColor = .black
        let separatorColor: UIColor = .systemBlue
        
        let separatorHeight: CGFloat = 2.0
        let sideTitlePadding: CGFloat = 16.0
        let separatorDivideWidth: CGFloat = 2.5
        let tabBarHeight: CGFloat = 80.0
    }
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let presenter: HomePresenterProtocol
    private let constants: Constants
    private let network: NetworkManagerProtocol = NetworkManager()
    
    private lazy var homeView: HomeView = {
        return HomeView()
    }()
    
    private lazy var searchView: SearchView = {
        return SearchView()
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        scroll.delegate = self
        scroll.addSubview(contentView)
        return scroll
    }()
    
    private lazy var homeTitleLabel: UILabel = {
        return createLabel(
            text: "Home", font: constants.titleLabelFont,
            textColor: constants.titleColor, alignment: .center
        )
    }()
    
    private lazy var searchTitleLabel: UILabel = {
        return createLabel(
            text: "Search", font: constants.titleLabelFont,
            textColor: constants.titleColor, alignment: .center
        )
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = constants.separatorColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(homeView)
        view.addSubview(searchView)
        homeView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        
        searchView.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.trailing)
            make.directionalVerticalEdges.equalToSuperview()
            make.width.equalTo(homeView)
        }
        return view
    }()
    
    // MARK: - Init
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        self.constants = Constants()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        hideKeyboardWhenTappedAround()
        presenter.viewDidLoad()
        homeView.delegate = self
        searchView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.frame.size = .init(
            width: view.frame.width * 2,
            height: view.frame.height - 220
        )
        mainScrollView.contentSize = contentView.frame.size
    }
}

extension HomeViewController: HomeViewInput {
    func preloadTrending(viewModel: [AllCategoryesViewModel]) {
        self.homeView.allCategoryesViewModel = viewModel
        self.homeView.reloadViews()
    }
    
//    func updateTableViewDataWithCurrentCategori(viewModels: [HomeViewCategoryTableViewModel]) {
//        self.homeView.tableViewModel = []
//        self.homeView.tableViewModel = viewModels
//        self.homeView.reloadViews()
//    }
    
    
    func updateSearchCollections(topViewModels: [SearchGenresViewModel], allViewModels: [SearchGenresViewModel]) {
        self.searchView.allGenresViewModel = allViewModels
        self.searchView.topGenresViewModel = topViewModels
        self.searchView.reloadCollections()
    }
    
    func updateTableView(viewModels: [HomeViewCategoryTableViewModel]) {
        self.homeView.tableViewModel = viewModels
        self.homeView.reloadViews()
    }
    
    func updateAllCategoryes(viewModels: [AllCategoryesViewModel]) {
        self.homeView.allCategoryesViewModel = viewModels
    }
    
    func updateMainCategoryCollection(viewModels: [CategoryViewModel]) {
        self.homeView.categoryesViewModel = viewModels
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / 2 + 16
        separatorView.frame.origin.x = x
    }
    
}

extension HomeViewController: UIScrollViewDelegate {

}

private extension HomeViewController {
    func addSubviews() {
        addSubviews(views: homeTitleLabel, searchTitleLabel, mainScrollView, separatorView)
    }
    
    func makeConstraints() {
        homeTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separatorView.snp.top).inset(-10)
            make.leading.equalToSuperview().inset(constants.sideTitlePadding)
        }
        
        searchTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separatorView.snp.top).inset(-10)
            make.trailing.equalToSuperview().inset(constants.sideTitlePadding)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(constants.tabBarHeight)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(constants.separatorHeight)
            make.width.equalTo(view.snp.width).dividedBy(constants.separatorDivideWidth)
            make.leading.equalToSuperview().inset(constants.sideTitlePadding)
            make.bottom.equalTo(mainScrollView.snp.top)
        }
    }
}

// MARK: - HomeView Delegate

extension HomeViewController : HomeSeeAllDelegate {
    func seeAllTaped() {
        presenter.didTapedSeeAllCategoryes()
    }
}

// MARK: - SearchView Delegate

extension HomeViewController : SearchSeeAllDelegate {
    func searchSeeAllTaped() {
        presenter.didTapesTopGenresSeeAll()
    }
    
}
