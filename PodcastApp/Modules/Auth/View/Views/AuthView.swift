import UIKit
import SnapKit

protocol AuthViewDelegate: AnyObject {
    func didTapLogin(email: String?, password: String?)
    func didTapRegister(email: String?, password: String?, confirmPassword: String?)
    func didTapGoogle()
}

fileprivate extension AuthView {
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

final class AuthView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AuthViewDelegate?
    
    private let appearance: Appearance
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Podcast App"
        label.textAlignment = .center
        label.textColor = appearance.labelColor
        label.font = appearance.titleFont
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login or register"
        label.textAlignment = .center
        label.textColor = appearance.labelColor
        label.font = appearance.subtitleFont
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = appearance.containerRadius
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "Email"
        label.textColor = .systemGray
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "Password"
        label.textColor = .systemGray
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var repeeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "Repeat Password"
        label.textColor = .systemGray
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let field = AuthTextField(fieldType: .email)
        field.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
        }
        field.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var passwordTextField: UITextField = {
        let field = AuthTextField(fieldType: .password)
        field.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
        }
        field.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let field = AuthTextField(fieldType: .confirmPassword)
        field.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
        }
        field.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.snp.makeConstraints { make in
            make.height.equalTo(appearance.buttonHeight)
        }
        button.titleLabel?.font = appearance.buttonTitleFont
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginRegister), for: .touchUpInside)
        button.backgroundColor = appearance.topBackgroundColor
        button.layer.cornerRadius = appearance.buttonHeight / 2.5
        return button
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = createStackView(views: [
            emailLabel, emailTextField, passwordLabel, passwordTextField,
            repeeatPasswordLabel, repeatPasswordTextField, loginButton
        ], axis: .vertical, spacing: 20, distribution: .fill, aligment: .fill
        )
        return stack
    }()
    
    private lazy var orContinueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = appearance.haveAccLabelColor
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "——— Or continue with ———"
        return label
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.snp.makeConstraints { make in
            make.height.equalTo(appearance.buttonHeight)
        }
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = appearance.buttonHeight / 2.5
        button.setImage(appearance.googleImage, for: .normal)
        button.setTitle("Continue with Google", for: .normal)
        button.titleLabel?.font = appearance.buttonTitleFont
        button.addTarget(self, action: #selector(didTapGoogle), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        let spacing: CGFloat = 12.0
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)


        return button
    }()
    
    private lazy var haveAccLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.haveAccLabelColor
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Don't have an account?"
        return label
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .trailing
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(appearance.signTitleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapSignButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stack = createStackView(
            views: [haveAccLabel, signButton],
            axis: .horizontal, spacing: 20,
            distribution: .fill, aligment: .fill
        )
        return stack
    }()
    
    private var isLoginState: Bool = true
    
    // MARK: - Init
    
    init(delegate: AuthViewDelegate) {
        self.delegate = delegate
        self.appearance = Appearance()
        super.init(frame: .zero)
        setupView()
        addSubviews()
        makeConstaints()
        updateUI(login: isLoginState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension AuthView {
    
}

// MARK: - Private

@objc private extension AuthView {
    func didTapSignButton() {
        isLoginState.toggle()
        updateUI(login: isLoginState)
    }
    
    func didTapLoginRegister() {
        isLoginState ? delegate?.didTapLogin(
            email: emailTextField.text, password: passwordTextField.text) :
        delegate?.didTapRegister(
            email: emailTextField.text, password: passwordTextField.text,
            confirmPassword: repeatPasswordTextField.text)
    }
    
    func didTapGoogle() {
        delegate?.didTapGoogle()
    }
    
    func didChangeText(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailLabel.alpha = textField.text?.isEmpty ?? false ? 0 : 1
        case passwordTextField:
            passwordLabel.alpha = textField.text?.isEmpty ?? false ? 0 : 1
        case repeatPasswordTextField:
            repeeatPasswordLabel.alpha = textField.text?.isEmpty ?? false ? 0 : 1
        default:
            break
        }
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
}

private extension AuthView {
    func setupView() {
        self.backgroundColor = appearance.topBackgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    func addSubviews() {
        [titleLabel, subtitleLabel, containerView].forEach({ self.addSubview($0) })
        [fieldsStack, orContinueLabel, googleButton, bottomStack]
            .forEach({ containerView.addSubview($0) })
    }
    
    func makeConstaints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(appearance.titleTopPadding)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.subitleTopPadding)
        }
        
        containerView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(self).multipliedBy(appearance.containerMultiplied)
        }
        
        fieldsStack.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(appearance.sidePadding)
            make.top.equalToSuperview().inset(36)
        }
        
        orContinueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fieldsStack.snp.bottom).offset(appearance.orContinueLabelTopPadding)
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orContinueLabel.snp.bottom).offset(45)
            make.directionalHorizontalEdges.equalToSuperview().inset(appearance.sidePadding)
        }
        
        bottomStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func updateUI(login: Bool) {
        loginButton.setTitle(isLoginState ? "Login" : "Register", for: .normal)
        signButton.setTitle(login ? "Sign Up" : "Login", for: .normal)
        haveAccLabel.text = login ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5) {
            [self.repeeatPasswordLabel, self.repeatPasswordTextField].forEach({
                $0.isHidden = login
                $0.alpha = login ? 0 : 1
            })
        }
        
        [emailTextField, passwordTextField, repeatPasswordTextField].forEach({
            $0.text = nil
        })
        [emailLabel, passwordLabel, repeeatPasswordLabel].forEach({
            $0.alpha = 0
        })
    }
    
    func createStackView(views: [UIView], axis: NSLayoutConstraint.Axis,
                         spacing: CGFloat,
                         distribution: UIStackView.Distribution = .fill,
                         aligment: UIStackView.Alignment = .center) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = aligment
        stack.distribution = .fill
        return stack
    }
}
