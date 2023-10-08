//
//  ProfileSettingViewController.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: BaseViewController {

    // MARK: - Properties
    private let presenter: ProfileSettingPresenterProtocol
    
    private let avatarView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backView")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .init(rgb: 0xFCD3D2)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        return createLabel(
            text: "Abigail Amaniah",
            font: .systemFont(ofSize: 16, weight: .bold),
            textColor: .init(rgb: 0x423F51),
            alignment: .left)
    }()
    
    private lazy var statusLabel: UILabel = {
        return createLabel(
            text: "Love, life and chill",
            font: .systemFont(ofSize: 14),
            textColor: .init(rgb: 0xA3A1AF),
            alignment: .left)
    }()
    
    private lazy var profileSettingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            ProfileSettingsTableViewCell.self,
            forCellReuseIdentifier: ProfileSettingsTableViewCell.reuseId
        )
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.init(rgb: 0x2882F1), for: .normal)
        button.tintColor = .init(rgb: 0x2882F1)
        button.contentHorizontalAlignment = .center
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(rgb: 0x2882F1).cgColor
        button.layer.cornerRadius = 32
        button.addTarget(self, action: #selector(logOutPressed), for: .touchUpInside)
        return button
    }()
    
    private var viewModels = [ProfileMainSettingsViewModel]()
    
    // MARK: - Init
    init(presenter: ProfileSettingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conformProtocols()
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
}

extension ProfileSettingViewController: ProfileSettingViewInput {
    func updateTable(viewModels: [ProfileMainSettingsViewModel]) {
        self.viewModels = viewModels
        profileSettingsTableView.reloadData()
    }
}

// MARK: - Extensions
private extension ProfileSettingViewController {
    func conformProtocols() {
        profileSettingsTableView.delegate = self
        profileSettingsTableView.dataSource = self
    }
    
    func addSubviews() {
        avatarView.addSubview(backImageView)
        avatarView.addSubview(profileImageView)
        addSubviews(views: avatarView, usernameLabel, statusLabel, profileSettingsTableView, logOutButton)
    }
    
    func makeConstraints() {
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(123)
            make.width.equalTo(80)
        }
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(31)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(48)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).inset(1)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(24)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(21)
        }
        
        profileSettingsTableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(41)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        logOutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(112)
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileSettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileSettingsTableViewCell.reuseId,
            for: indexPath) as? ProfileSettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(viewModel: viewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileSettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        viewModel.action()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
}

// MARK: - Target Actions
extension ProfileSettingViewController {
    
    @objc func logOutPressed() {
        presenter.didTapLogOut()
    }
}
