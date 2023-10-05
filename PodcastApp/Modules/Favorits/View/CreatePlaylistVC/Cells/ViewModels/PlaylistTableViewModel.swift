import UIKit.UIImage

struct PlaylistTableViewModel {
    let image : UIImage
    let listName : String
    let authorName : String
    let duration : String
    let action: () -> ()
}
