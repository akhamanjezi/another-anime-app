import Foundation

struct Anime {
    var title: String?
    var genres: [String]?
    var releaseDate: Date?
    var synopsis: String?
    var averageRating: String?
    var ageRating: String?
    var imageURL: String?
    var thumnail: Data?
    var duration: Duration?
    var externalID: String?
    var source: AnimeSources?
}

enum AnimeSources {
    case kitsu
}
