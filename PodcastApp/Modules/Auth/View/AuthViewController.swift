import UIKit

final class AuthViewController: UIViewController {
    
    private let authView: UIView
    
    private let presenter: AuthPresenterProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.addSubview(authView)
        return scroll
    }()
    
    init(presenter: AuthPresenterProtocol, view: UIView) {
        self.presenter = presenter
        self.authView = view
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
    
}
