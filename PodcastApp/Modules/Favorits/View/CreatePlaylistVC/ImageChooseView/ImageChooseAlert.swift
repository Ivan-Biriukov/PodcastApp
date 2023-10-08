import UIKit
import SnapKit

final class ImageChooseAlert {
    
    static let shared = ImageChooseAlert()
    
    struct Constants {
        static let backgroundAlhpaTo : CGFloat = 0.6
    }
                
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var myTargetView: UIView?
    private var myTargetVC : UIViewController?
        
    func showAlert(on viewController: UIViewController) {
        
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        myTargetVC = viewController
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        setupAlertViewInnerUI()
        
        alertView.frame = CGRect(x: 0, y: targetView.frame.size.height + 360 , width: targetView.frame.size.width , height: 360)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.backgroundView.alpha = Constants.backgroundAlhpaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.45, animations: {
                    self.alertView.frame = CGRect(x: 0, y: targetView.frame.size.height - 360, width: targetView.frame.size.width, height: 360)
                })
            }
        })
    }
    
    func dismissAlert() {
        guard let targetView = myTargetView else {return}
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 0, y: targetView.frame.size.height , width: targetView.frame.size.width , height: 360)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: {done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                } )
            }
        })
    }
}

 extension ImageChooseAlert {
    
    @objc func backTaped() {
        dismissAlert()
    }
    
     @objc func selectLocalTaped() {
        
        let photoPikerView : UIImagePickerController = {
            let piker = UIImagePickerController()
            return piker
        }()
        
        myTargetVC?.present(photoPikerView, animated: true)
        self.dismissAlert()
    }
    
    @objc func seeAllTaped() {
        
    }
}

private extension ImageChooseAlert {
    
    func setupAlertViewInnerUI() {
        
        lazy var backButton : UIButton = {
            let btn = UIButton(type: .system)
            btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn.tintColor = .black
            btn.addTarget(self, action: #selector(backTaped), for: .touchUpInside)
            return btn
        }()
        
        lazy var titleLabel : UILabel = {
            let lb = UILabel()
            lb.font = .systemFont(ofSize: 16, weight: .bold)
            lb.textColor = .init(rgb: 0x423F51)
            lb.textAlignment = .center
            lb.text = "Change Cover"
            return lb
        }()
        
        lazy var titleStack : UIStackView = {
            let st = UIStackView()
            st.axis = .horizontal
            st.distribution = .equalSpacing
            st.alignment = .center
            return st
        }()
        
        lazy var choosenTitle : UILabel = {
            let lb = UILabel()
            lb.font = .systemFont(ofSize: 14, weight: .bold)
            lb.textColor = .init(rgb: 0x747183)
            lb.textAlignment = .left
            lb.text = "Choose image"
            return lb
        }()
        
        lazy var seeAllButton : UIButton = {
            let btn = UIButton(type: .system)
            btn.setTitle("See all", for: .normal)
            btn.setTitleColor(UIColor.init(rgb: 0xA4A2B0), for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            btn.addTarget(self, action: #selector(seeAllTaped), for: .touchUpInside)
            return btn
        }()
        
        let firstSquare = PlaceholderView()
        let secondSquare = PlaceholderView()
        let thirdSquare = PlaceholderView()
        
        lazy var squareStack : UIStackView = {
            let st = UIStackView()
            st.axis = .horizontal
            st.distribution = .equalSpacing
            st.alignment = .center
            return st
        }()
        
        lazy var selectLocalButton : UIButton = {
            let btn = UIButton(type: .system)
            btn.setTitle("Select from local files", for: .normal)
            btn.setTitleColor(UIColor.init(rgb: 0xA4A2B0), for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            btn.setImage(UIImage(named: "Folder"), for: .normal)
            btn.backgroundColor = .init(rgb: 0xEDF0FC)
            btn.tintColor = .init(rgb: 0x747183)
            btn.addTarget(self, action: #selector(selectLocalTaped), for: .touchUpInside)
            btn.layer.cornerRadius = 16
            return btn
        }()
        
        [backButton, titleLabel, titleStack, squareStack, selectLocalButton].forEach({alertView.addSubview($0)})
        [choosenTitle, seeAllButton].forEach({titleStack.addArrangedSubview($0)})
        [firstSquare, secondSquare, thirdSquare].forEach({squareStack.addArrangedSubview($0)})
        
        leftPadding(value: 67, button: selectLocalButton)
        
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(39)
            make.centerX.equalTo(alertView.snp.centerX)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-31)
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(28)
        }
        
        squareStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).inset(-14)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        selectLocalButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.bottom.equalToSuperview().inset(32)
        }
    }
    
    private func leftPadding(value: CGFloat, button: UIButton) {
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: value).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }
}

final private class PlaceholderView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .init(rgb: 0xD9D9D9)
        layer.cornerRadius = 16

        self.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
    }
}
