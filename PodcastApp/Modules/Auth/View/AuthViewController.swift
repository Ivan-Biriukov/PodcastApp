import UIKit
import ProgressHUD

final class AuthViewController: UIViewController {
    
    private lazy var authView: UIView = {
        let view = AuthView(delegate: self)
        return view
    }()
    
    private let presenter: AuthPresenterProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.addSubview(authView)
        return scroll
    }()
    
    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authView.frame.size = .init(
            width: view.frame.width,
            height: 800
        )
        scrollView.contentSize = authView.frame.size
    }
}

extension AuthViewController: AuthViewInput {
    func showError(error: String) {
        ProgressHUD.showError(error)
    }
    
    func showSuccess(with text: String) {
        ProgressHUD.showSuccess("Success")
    }
}

extension AuthViewController: AuthViewDelegate {
    func didTapLogin(email: String?, password: String?) {
        guard let email, let password, !email.isEmpty, !password.isEmpty else {
            ProgressHUD.showError("All fields are required")
            return
        }
        presenter.loginUser(email: email, password: password)
    }
    
    func didTapRegister(email: String?, password: String?, confirmPassword: String?) {
        guard let email, let password, let confirmPassword,
              !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            ProgressHUD.showError("All fields are required")
            return
        }
        presenter.registerUser(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    func didTapGoogle() {
        presenter.loginWithGoogle()
    }
}
