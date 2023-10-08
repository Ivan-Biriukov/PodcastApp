import Foundation
import RealmSwift

enum FavoritsType {
    case favorite
}

final class SavingManager {
    
    static let shared = SavingManager()
    
    private let realm: Realm? = {
        let config = Realm.Configuration(schemaVersion: 1)
        { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
            }
        }
        do {
            let realm = try Realm(configuration: config)
            return realm
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }()
}

// MARK: - Public

extension SavingManager {
    func fetchUser(for id: String, completion: @escaping (RealmUserModel?) -> Void) {
        let user = realm?.objects(RealmUserModel.self).first(where: { $0.userID == id }) //.where({ $0.userID == id })
        completion(user)
    }
    
    func saveUser(user: RealmUserModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try realm?.write({
                realm?.add(user)
            })
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
}

// MARK: - Saving Protocol

/*

extension SavingManager: SavingManagerProtocol {

    func saveUser(user: RealmUserModel, completion: @escaping (Bool) -> Void) {
        do {
            try realm?.write {
                realm?.add(user)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    func fetchAllUsers(completion: @escaping ([RealmUserModel]) -> Void) {
        guard let users = realm?.objects(RealmUserModel.self) else { return }
        completion(Array(users))
    }
    
    func removeObject(object: RealmSwift.Object, completion: @escaping (Bool) -> Void) {
        do {
            try realm?.write({
                realm?.delete(object)
                completion(true)
            })
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func removeAll(completion: @escaping (Bool) -> Void) {
        do {
            try realm?.write({
                realm?.deleteAll()
                completion(true)
            })
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func isExistRealmUser(userId: String) -> Bool {
        guard let users = realm?.objects(RealmUserModel.self) else { return false }
        return users.filter({ $0.userID == userId }).count > 0
    }
    
    func fetchRealmUser(userId: String, completion: @escaping (RealmUserModel?) -> Void) {
        guard let realmUsers = realm?.objects(RealmUserModel.self) else { return }
        let users = Array(realmUsers)
        let user = users.filter({ $0.userID == userId }).first
        completion(user)
    }
    
    func updateUserData(user: RealmUserModel, userName: String, avatarImageData: Data, email: String, completion: (Bool) -> Void) {
        do {
            try realm?.write({
                user.username = userName
                user.avatarImageData = avatarImageData
                user.email = email
                completion(true)
            })
        } catch {
            completion(false)
            print(error.localizedDescription)
        }
    }
    
    func fetchFavorits(userId: String, favoritType: FavoritsType, completion: @escaping ([SavedFavoritsRealmModel]) -> Void) {
        switch favoritType {
        case .favorite:
            fetchAllUsers { users in
                for user in users where user.userID == userId {
                    completion(Array(_immutableCocoaArray: user.selfsLists))
                }
            }
        }
    }
    
    func isLikedElement(for user: RealmUserModel, with elementId: Int) -> Bool {
        let likes = user.favoritsLists
        for like in likes {
            if like.id == elementId {
                return true
            }
        }
        return false
    }
    
    func saveElement(for user: RealmUserModel, with elementId: Int, elementType: FavoritsType, completion: @escaping (Bool) -> Void) {
        let element = SavedFavoritsRealmModel()
        element.id = elementId
        
        switch elementType {
        case .favorite:
            do {
                try realm?.write({
                    user.favoritsLists.append(element)
                    completion(true)
                })
            } catch {
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func removeElement(for user: RealmUserModel, with elementId: Int, completion: @escaping (Bool) -> Void) {
        let elements = user.favoritsLists
        
        for (index, element) in elements.enumerated() {
            if element.id == elementId {
                do {
                    try realm?.write({
                        elements.remove(at: index)
                        completion(true)
                    })
                } catch {
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        }
    }
}

*/
