import UIKit.UIColor

struct HomeViewCategoryTableViewModel {
    //let imageURLString: String
    let color : UIColor
    let podcastName : String
    let authorName : String
    let podcastCategoryName : String
    let episodsCount : String
    let savedToFavorits : Bool
    let action: () -> ()
}
