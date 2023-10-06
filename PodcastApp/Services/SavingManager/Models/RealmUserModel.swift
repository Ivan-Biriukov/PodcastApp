import Foundation
import RealmSwift

final class RealmUserModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String = ""
    @Persisted var email: String = ""
    @Persisted var userID: String = ""
    @Persisted var avatarImageData: Data = Data()
    var favoritsLists = List<SavedFavoritsRealmModel>()
    var selfsLists = List<SelfRealmSavedLists>()
    
    convenience init(username: String, email: String, userID: String, avatarImageData: Data = Data()) {
        self.init()
        self.username = username
        self.email = email
        self.userID = userID
        self.avatarImageData = avatarImageData
    }
}
