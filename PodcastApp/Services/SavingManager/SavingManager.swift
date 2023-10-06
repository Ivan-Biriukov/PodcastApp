import Foundation
import RealmSwift

final class SavingManager {
    
    static let shared = SavingManager()
    
    private init (){}
    
    private var realm: Realm? {
        return try? Realm()
    }
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
