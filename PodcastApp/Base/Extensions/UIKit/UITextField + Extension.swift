import UIKit.UITextField

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    internal func addBottomBorder(height: CGFloat , color: UIColor) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
}
