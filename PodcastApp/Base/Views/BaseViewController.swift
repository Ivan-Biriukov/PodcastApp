import UIKit

extension BaseViewController {
    struct BaseConstants {
        
    }
}

class BaseViewController: UIViewController {
    
    let constants = BaseConstants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func addSubviews(views: UIView...) {
        views.forEach({ view.addSubview($0) })
    }
    
    func createStackView(
        for views: UIView..., axis: NSLayoutConstraint.Axis,
        spacing: CGFloat,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill
    ) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = distribution
        stack.alignment = alignment
        return stack
    }
    
    func createLabel(
        text: String, font: UIFont, textColor: UIColor,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
    
    func createTitleButton(title: String, titleColor: UIColor, font: UIFont) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        return button
    }
}
