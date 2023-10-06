import Foundation

struct ChannelCellViewModel {
    let channelImgURLString : String
    let channelName : String
    var episodes : [Episode]
}

struct Episode {
    let episodeImgURLString : String
    let name : String
    let timeDuration : Int
    let episodesCount : String
    let id : Int
}
