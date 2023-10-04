import UIKit.UIColor

struct HomeViewCategoryTableViewModel {
    let imageURLString: String
    let podcastName : String
    let authorName : String
    let podcastCategoryName : String
    let episodsCount : String
    var savedToFavorits : Bool
    let action: () -> ()
}
