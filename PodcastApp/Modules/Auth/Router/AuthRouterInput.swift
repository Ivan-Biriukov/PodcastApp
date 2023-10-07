import Foundation
import FirebaseAuth

protocol AuthRouterInput {
    func showSuccess(with text: String)
    func showError(with error: String)
    func routeToMainApp(user: RealmUserModel)
    func routeToContinueRegister(user: User)
}
