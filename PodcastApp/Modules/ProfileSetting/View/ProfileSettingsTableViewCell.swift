//
//  ProfileSettingsTableViewCell.swift
//  ProfileSettings
//
//  Created by Ilyas Tyumenev on 27.09.2023.
//

import UIKit

final class ProfileSettingsTableViewCell: UITableViewCell {
    
    static let reuseId = "ProfileSettingsTableViewCell"
    
    // MARK: - Private Properties
    private let leftView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .init(rgb: 0xEDF0FC)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stroke")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addSubviews()
        makeConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func fill(viewModel: ProfileMainSettingsViewModel) {
        title.text = viewModel.title
        leftImage.image = UIImage(named: viewModel.imageName)
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
    }
    
    private func addSubviews() {
        //[leftView, title, rightImage].forEach({ contentView.addSubview($0) })
        leftView.addSubview(leftImage)
        contentView.addSubview(leftView)
        contentView.addSubview(title)
        contentView.addSubview(rightImage)
    }
    
    private func makeConstraints() {
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        leftImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftView.snp.trailing).offset(16)
            make.trailing.equalTo(rightImage.snp.leading).inset(37)
            make.height.equalTo(24)
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
}
