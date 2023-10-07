import Foundation
import RealmSwift

protocol SavingManagerProtocol {
    func saveUser(user: RealmUserModel, completion: @escaping (Bool) -> Void)
    func fetchAllUsers(completion: @escaping ([RealmUserModel]) -> Void)
    func removeObject(object: Object, completion: @escaping (Bool) -> Void)
    func removeAll(completion: @escaping (Bool) -> Void)
    func isExistRealmUser(userId: String) -> Bool
    func fetchRealmUser(userId: String,
                        completion: @escaping (RealmUserModel?) -> Void)
    func updateUserData(user: RealmUserModel, userName: String, avatarImageData: Data, email: String, completion: (Bool) -> Void)
    func fetchFavorits(userId: String, favoritType: FavoritsType, completion: @escaping ([SavedFavoritsRealmModel]) -> Void)
    func isLikedElement(for user: RealmUserModel, with elementId: Int) -> Bool
    func saveElement(for user: RealmUserModel, with elementId: Int, elementType: FavoritsType,
                   completion: @escaping (Bool) -> Void)
    func removeElement(for user: RealmUserModel, with elementId: Int,
                     completion: @escaping (Bool) -> Void)
}
