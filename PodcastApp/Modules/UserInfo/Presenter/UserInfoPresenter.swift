import Foundation
import FirebaseAuth

final class UserInfoPresenter {
    weak var view: UserInfoViewInput?
    
    private let peerUser: User
    private let router: UserInfoRouter
    private let interactor: UserInfoInteractorInput
    
    init(router: UserInfoRouter, interactor: UserInfoInteractorInput, user: User) {
        self.router = router
        self.interactor = interactor
        self.peerUser = user
    }
}

extension UserInfoPresenter: UserInfoPresenterProtocol {
    func didTapStart(firstName: String, lastName: String) {
        guard let email = peerUser.email, !firstName.isEmpty else { return }
        let realmUser: RealmUserModel = .init(
            username: firstName + " \(lastName)",
            email: email, userID: peerUser.uid)
        interactor.saveUserToDB(user: realmUser) { [weak self] result in
            switch result {
            case .success:
                self?.router.routeToMainApp(user: realmUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
