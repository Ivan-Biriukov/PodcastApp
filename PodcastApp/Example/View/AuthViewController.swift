import UIKit

final class ExampleViewController: BaseViewController {
    
    private let presenter: ExamplePresenterProtocol
    
    init(presenter: ExamplePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

extension ExampleViewController: ExampleViewInput {
    func changeBackground() {
        view.backgroundColor = .systemRed
    }
}
