import Foundation

final class UserInfoInteractor {
    
}

extension UserInfoInteractor: UserInfoInteractorInput {
    func saveUserToDB(user: RealmUserModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        SavingManager.shared.saveUser(user: user, completion: completion)
    }
}
