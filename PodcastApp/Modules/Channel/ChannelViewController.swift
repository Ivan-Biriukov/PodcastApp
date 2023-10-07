import UIKit
import SnapKit
import Kingfisher

class ChannelViewController: BaseViewController {
    
    // MARK: - Propertyes
    
    var viewModels : ChannelCellViewModel
    
    // MARK: - UI Elements
    
    private lazy var backButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = .init(rgb: 0x423F51)
        btn.addTarget(self, action: #selector(backTaped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLabel : UILabel = {
        return createLabel(text: "Сhannel", font: .systemFont(ofSize: 16, weight: .bold), textColor: .init(rgb: 0x423F51))
    }()
    
    private lazy var threeDotsButton : UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private lazy var titleStack : UIStackView = {
        let stack = createStackView(for: backButton, titleLabel, threeDotsButton, axis: .horizontal, spacing: 0)
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var channelImageView : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 84).isActive = true
        img.widthAnchor.constraint(equalToConstant: 84).isActive = true
        img.backgroundColor = .init(rgb: 0xAEE2F3)
        img.layer.masksToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 21
        return img
    }()
    
    private lazy var resultLabel : UILabel = {
        let lb = createLabel(text: viewModels.channelName, font: .systemFont(ofSize: 16, weight: .bold), textColor: .init(rgb: 0x423F51))
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var tableViewLabel : UILabel = {
        return createLabel(text: "All Episodes", font: .systemFont(ofSize: 16, weight: .bold), textColor: .init(rgb: 0x423F51))
    }()
    
    private lazy var tableView : UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.isUserInteractionEnabled = true
        tb.delegate = self
        tb.dataSource = self
        tb.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.reuseId)
        return tb
    }()
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Init
    
     init(viewModels : ChannelCellViewModel) {
         self.viewModels = viewModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Buttons Methods

private extension ChannelViewController {
    
    @objc func backTaped() {
        self.dismiss(animated: true)
    }
}

// MARK: - Configure

private extension ChannelViewController {
    
    func addSubviews() {
        addSubviews(views: titleStack, channelImageView, resultLabel, tableViewLabel, tableView)
        [backButton, titleLabel, threeDotsButton].forEach({titleStack.addArrangedSubview($0)})
    }
    
    func setupConstraints() {
        
        titleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(56)
        }
        
        channelImageView.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).inset(-33)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(channelImageView.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        tableViewLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).inset(-34)
            make.leading.equalToSuperview().inset(32)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewLabel.snp.bottom).inset(-13)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

// MARK: - TableView Delegate

extension ChannelViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

// MARK: - TableView DataSource

extension ChannelViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.episodes.count - 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.reuseId, for: indexPath) as? ChannelTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(viewModel: viewModels.episodes[indexPath.row])
        
        return cell
    }
}
