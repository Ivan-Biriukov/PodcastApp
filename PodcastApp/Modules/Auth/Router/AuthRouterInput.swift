import Foundation

protocol AuthRouterInput {
    func showSuccess(with text: String)
    func showError(with error: String)
    func routeToMainApp()
}
