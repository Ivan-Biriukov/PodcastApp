import Foundation

protocol UserInfoInteractorInput {
    func saveUserToDB(user: RealmUserModel, completion: @escaping (Result<Bool, Error>) -> Void)
}
