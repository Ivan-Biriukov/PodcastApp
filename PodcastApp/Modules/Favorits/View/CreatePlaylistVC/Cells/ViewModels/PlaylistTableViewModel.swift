import UIKit.UIImage

struct PlaylistTableViewModel {
    let imageURLString : String
    let listName : String
    let authorName : String
    let duration : String
    let action: () -> ()
}
