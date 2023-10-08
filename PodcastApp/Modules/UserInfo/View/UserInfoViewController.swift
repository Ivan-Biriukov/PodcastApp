import UIKit
import SnapKit

fileprivate extension UserInfoViewController {
    struct Appearance {
        let topBackgroundColor: UIColor = .init(rgb: 0x2882F1)
        let labelColor: UIColor = .white
        let haveAccLabelColor: UIColor = .init(rgb: 0x6C6C6C)
        let signTitleColor: UIColor = .init(rgb: 0x514EB6)
        
        let titleFont: UIFont = .systemFont(ofSize: 24, weight: .bold)
        let subtitleFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
        let buttonTitleFont: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        
        let googleImage: UIImage? = UIImage.Auth.googleImage?.withRenderingMode(.alwaysOriginal)
        
        let containerMultiplied: CGFloat = 0.85
        let sidePadding: CGFloat = 16.0
        let containerRadius: CGFloat = 30.0
        let titleTopPadding: CGFloat = 54.0
        let subitleTopPadding: CGFloat = 8.0
        let buttonHeight: CGFloat = 56.0
        let fieldHeight: CGFloat = 45.0
        let orContinueLabelTopPadding: CGFloat = 45.0
    }
}

final class UserInfoViewController: BaseViewController {
    private let presenter: UserInfoPresenterProtocol
    private let appearance: Appearance
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Complet your account"
        label.textAlignment = .center
        label.textColor = appearance.labelColor
        label.font = appearance.titleFont
        return label
    }()
    
    private lazy var firstNameField: UITextField = {
        let field = AuthTextField(fieldType: .firstName)
        field.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
        }
        field.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var lastNameField: UITextField = {
        let field = AuthTextField(fieldType: .password)
        field.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
        }
        field.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.snp.makeConstraints { make in
            make.height.equalTo(appearance.buttonHeight)
        }
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = appearance.buttonTitleFont
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        button.backgroundColor = appearance.topBackgroundColor
        button.layer.cornerRadius = appearance.buttonHeight / 2.5
        return button
    }()
    
    init(presenter: UserInfoPresenterProtocol) {
        self.presenter = presenter
        self.appearance = Appearance()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstaints()
    }
}

extension UserInfoViewController: UserInfoViewInput {
    
}

@objc private extension UserInfoViewController {
    func didTapStart() {
        
    }
    
    func didChangeText(_ textField: UITextField) {
        
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
}

private extension UserInfoViewController {
    func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addSubviews() {
        [titleLabel, firstNameField, lastNameField].forEach({ view.addSubview($0) })
    }
    
    func makeConstaints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(appearance.titleTopPadding)
        }
        
        firstNameField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(appearance.sidePadding)
            make.top.equalToSuperview().inset(36)
        }
        
        lastNameField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(appearance.sidePadding)
            make.top.equalTo(firstNameField.snp.bottom).offset(36)
        }
    }
}
