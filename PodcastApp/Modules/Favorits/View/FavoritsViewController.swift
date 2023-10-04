import UIKit

extension FavoritsViewController {
    struct Constants {
        
    }
}

class FavoritsViewController: BaseViewController {
    
    // MARK: - Propertyes
    
    private let presenter: FavoritsPresenterProtocol
    private let constants: Constants
    
    
    // MARK: - LifeCycleMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Init
    
    init(presenter: FavoritsPresenterProtocol) {
        self.presenter = presenter
        self.constants = Constants()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritsViewController : FavoritsViewInput {
    
}
