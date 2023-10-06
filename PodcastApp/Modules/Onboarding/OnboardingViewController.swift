import UIKit

final class OnboardingViewController: BaseViewController {
    
    //MARK: - UIElements
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(components: 0.16, green: 0.51, blue: 0.95, alpha: 0.37)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainTitle: UILabel = {
       let label = createLabel(text: "SUPER APP SUPER APP SUPER APP", font: .boldSystemFont(ofSize: 34), textColor: UIColor(rgb: 0x413E50))
        
        
        return label
    }()
    
//    private var descriptionLabel: UILabel = {
//       let label = createLabel(text: <#T##String#>, font: <#T##UIFont#>, textColor: <#T##UIColor#>)
//
//
//        return label
//    }()
    
    private var labelsStackView = UIStackView()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.setTitle("Next", for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.tintColor = UIColor(rgb: 0x413E50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var buttonsStackView = UIStackView()
    
    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor(rgb: 0x413E50)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private var mainStackView = UIStackView()
//    private var mainStackView: UIStackView = {
//       return createStackView(for: labelsStackView, buttonsStackView, pageControl, axis: .vertical, spacing: 20)
//    }()
    
    //MARK: - Initialize
//    init(labelsStackView: UIStackView = UIStackView(), nextButton: UIButton, skipButton: UIButton, buttonsStackView: UIStackView = UIStackView(), mainStackView: UIStackView = UIStackView()) {
//        self.labelsStackView = labelsStackView
//        self.nextButton = nextButton
//        self.skipButton = skipButton
//        self.buttonsStackView = buttonsStackView
//        self.mainStackView = mainStackView
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Methods
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(backgroundView)
        
//        mainTitle =
        descriptionLabel = createLabel(text: "SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP", font: .systemFont(ofSize: 15), textColor: UIColor(rgb: 0x413E50))
        
        labelsStackView = createStackView(for: mainTitle, descriptionLabel, axis: .vertical, spacing: 16)
        buttonsStackView = createStackView(for: nextButton, skipButton, axis: .horizontal, spacing: 89)
        mainStackView = createStackView(for: labelsStackView, buttonsStackView, pageControl, axis: .vertical, spacing: 20)
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        backgroundView.addSubview(mainStackView)
    }
    
    @objc private func nextButtonTapped() {
        
    }
    
    @objc private func skipButtonTapped() {
        
    }
}

//MARK: - Set Constraints
extension OnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -20),
            
            backgroundView.heightAnchor.constraint(equalToConstant: 359),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            mainStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
            mainStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -30),
        ])
    }
}
