import UIKit
import SnapKit

class SearchResultsViewController: BaseViewController {
    
    // MARK: - Propertyes
    
    private let textDarkColor : UIColor = .init(rgb: 0x423F51)
    private let textLightColor : UIColor = .init(rgb: 0xA3A1AF)
    private var currentResults : [SearchResultViewModel]
    private var allPodcastsResults : [SearchResultAllPodcastsViewModel]
    private var searchText : String
    
    // MARK: - UI Elements
        
    private lazy var resultsTextLabel : UILabel = {
        return createLabel(text: searchText, font: .systemFont(ofSize: 14, weight: .regular), textColor: textDarkColor)
    }()

    private lazy var cancelButton : UIButton = {
        let btn = UIButton()
        btn.setImage(.Main.closeSquareImage, for: .normal)
        btn.tintColor = textLightColor
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(cancelTaped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var separateView : UIView = {
        let view = UIView()
        view.backgroundColor = .init(rgb: 0xDFDDEB)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var resultTitleLabel : UILabel = {
        return createLabel(text: "Search Result", font: .systemFont(ofSize: 14, weight: .bold), textColor: textDarkColor)
    }()
    
    private lazy var resultsTableView : UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.register(SearchResultCurrentTableViewCell.self, forCellReuseIdentifier: SearchResultCurrentTableViewCell.reuseId)
        return tb
    }()
    
    private lazy var allPodcastLabel : UILabel = {
        return createLabel(text: "All Podcast", font: .systemFont(ofSize: 14, weight: .regular), textColor: textLightColor)
    }()
    
    private lazy var allPodcastTableView : UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.register(AllResultsTableViewCell.self, forCellReuseIdentifier: AllResultsTableViewCell.reuseId)
        return tb
    }()
    
    // MARK: - Init
    
    init(currentResults: [SearchResultViewModel], allPodcastsResults: [SearchResultAllPodcastsViewModel], searchText: String) {
        self.currentResults = currentResults
        self.allPodcastsResults = allPodcastsResults
        self.searchText = searchText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(views: resultsTextLabel, cancelButton, separateView, resultTitleLabel, resultsTableView, allPodcastLabel, allPodcastTableView)
        setupConstraint()
        view.backgroundColor = .white
    }
    
    // MARK: - Buttons Methods
    
    @objc private func cancelTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            sender.alpha = 1
            self.dismiss(animated: true)
        })
    }
    
    // MARK: - Configure
    
    private func setupConstraint() {
        resultsTextLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(49)
            make.leading.equalTo(view.snp.leading).inset(32)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(49)
            make.trailing.equalTo(view.snp.trailing).inset(32)
        }
        
        separateView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(88)
            make.leading.equalTo(view.snp.leading).inset(32)
            make.trailing.equalTo(view.snp.trailing).inset(32)
        }
        
        resultTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).inset(-24)
            make.leading.equalTo(view.snp.leading).inset(32)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(resultTitleLabel.snp.bottom).inset(-12)
            make.height.equalTo(60)
        }
        
        allPodcastLabel.snp.makeConstraints { make in
            make.top.equalTo(resultsTableView.snp.bottom).inset(-22)
            make.leading.equalTo(view.snp.leading).inset(32)
        }
        
        allPodcastTableView.snp.makeConstraints {make in
            make.top.equalTo(allPodcastLabel.snp.bottom).inset(-12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension SearchResultsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case resultsTableView:
            return 60
        default:
            return 88
        }
    }
}

// MARK: - TableView DataSource

extension SearchResultsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case resultsTableView:
            return currentResults.count
        default:
            return allPodcastsResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case resultsTableView:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultCurrentTableViewCell.reuseId,
                for: indexPath) as? SearchResultCurrentTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(viewModel: currentResults[indexPath.row])
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AllResultsTableViewCell.reuseId,
                for: indexPath) as? AllResultsTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(viewModel: allPodcastsResults[indexPath.row])
            return cell
        }
    }
}
