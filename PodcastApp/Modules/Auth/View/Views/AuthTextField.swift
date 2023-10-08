import UIKit

enum AuthTextFieldType {
    case email
    case password
    case confirmPassword
    case firstName
    case lastName
    
    var placeholder: String {
        switch self {
        case .email:
            return "Enter your email address"
        case .password:
            return "Enter your password"
        case .confirmPassword:
            return "Confirm your password"
        case .firstName:
            return "First name"
        case .lastName:
            return "Last name"
        }
    }
}

final class AuthTextField: UITextField {
    
    private let fieldType: AuthTextFieldType
    
    init(fieldType: AuthTextFieldType) {
        self.fieldType = fieldType
        super.init(frame: .zero)
        setupField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
}

private extension AuthTextField {
    func setupField() {
        backgroundColor = .init(rgb: 0xF6F8FE)
        clipsToBounds = true
        layer.cornerRadius = 24
        placeholder = fieldType.placeholder
        borderStyle = .none
        autocorrectionType = .no
        autocapitalizationType = .none
        
        switch fieldType {
        case .email:
            keyboardType = .emailAddress
        case .password:
            isSecureTextEntry = true
        case .confirmPassword:
            isSecureTextEntry = true
        case .firstName, .lastName: break
        }
    }
}
