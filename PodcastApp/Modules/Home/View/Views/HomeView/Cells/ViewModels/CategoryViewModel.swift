import UIKit.UIColor

struct CategoryViewModel {
    let genreTitle: String
    let podcastCount: String
    //let imageURLString : String
    let backgroundColor : UIColor
    let action: () -> ()
}

struct AllCategoryesViewModel {
    let id : Int
    let categoryName : String
    var isItemSelected : Bool
    let action: () -> ()
}

