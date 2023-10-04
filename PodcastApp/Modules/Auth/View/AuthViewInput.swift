import Foundation

protocol AuthViewInput: AnyObject {
    func showError(error: String)
    func showSuccess(with text: String)
}
