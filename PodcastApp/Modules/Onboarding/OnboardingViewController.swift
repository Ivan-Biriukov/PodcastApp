import UIKit

//MARK: - Model
struct OnboardingStruct {
    let backgroundImage: UIImage
}

final class OnboardingViewController: BaseViewController {
    
    //MARK: - UI
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
        view.backgroundColor = UIColor(red: 0.16, green: 0.51, blue: 0.95, alpha: 0.35)
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainTitleLabel: UILabel = {
       let label = createLabel(text: "SUPER APP\nSUPER APP\nSUPER APP", font: .boldSystemFont(ofSize: 34), textColor: UIColor(rgb: 0x413E50))
        label.numberOfLines = 3
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = createLabel(text: "SUPER APP SUPER APP SUPER APP\nSUPER APP SUPER APP SUPER APP\nSUPER APP SUPER APP SUPER APP", font: .systemFont(ofSize: 15), textColor: UIColor(rgb: 0x413E50))
        label.numberOfLines = 3
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = createStackView(for: mainTitleLabel, descriptionLabel, axis: .vertical, spacing: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nextButton: UIButton = {
        let button = createTitleButton(title: "Next", titleColor: UIColor(rgb: 0x413E50), font: .systemFont(ofSize: 17))
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 85).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = createTitleButton(title: "Skip", titleColor: UIColor(rgb: 0x413E50), font: .systemFont(ofSize: 17))
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = createStackView(for: skipButton, nextButton, axis: .horizontal, spacing: 89)
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        pageControl.numberOfPages = 3
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor(rgb: 0x413E50)
        pageControl.pageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stack = createStackView(for: labelsStackView, buttonsStackView, pageControl, axis: .vertical, spacing: 20)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Properties
    private let idOnboardingCell = "idOnboardingCell"
    private var onboardingArray = [OnboardingStruct]()
    private var collectionItem = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Methods
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(mainStackView)
        setupScreens()
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupScreens() {
        guard let firstImage = UIImage(named: "firstImage"),
        let secondImage = UIImage(named: "secondImage"),
        let thirdImage = UIImage(named: "thirdImage") else {
            return
        }
        
        let firstScreen = OnboardingStruct(backgroundImage: firstImage)
        let secondScreen = OnboardingStruct(backgroundImage: secondImage)
        let thirdScreen = OnboardingStruct(backgroundImage: thirdImage)
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    
    @objc private func nextButtonTapped() {
        if collectionItem == 0 {
            nextPage()
            mainTitleLabel.text = "APP SUPER\nAPP SUPER\nAPP SUPER"
        } else if collectionItem == 1 {
            nextPage()
            mainTitleLabel.text = "SAP\nSAP\nSAP"
            nextButton.setTitle("Get Started", for: .normal)
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.backgroundColor = UIColor(rgb: 0x2882F1)
            skipButton.isHidden = true
        } else if collectionItem == 2 {
            saveUserDefaults()
            showHomeScreen()
        }
    }
    
    @objc private func skipButtonTapped() {
        showHomeScreen()
    }
    
    private func nextPage() {
        collectionItem += 1
        let index: IndexPath = [0, collectionItem]
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = collectionItem
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }
    
    private func showHomeScreen() {
//        let resultVC = AuthViewController()
//        resultVC.modalPresentationStyle = .fullScreen
//        present(resultVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - Constraints
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
