import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        addSubview(backgroundImageView)
    }
    
    public func cellConfigure(model: OnboardingStruct) {
        backgroundImageView.image = model.backgroundImage
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.78),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.78)
        ])
    }
}
