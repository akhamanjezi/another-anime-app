import Foundation

struct SavedAnime: Codable, Comparable {
    var title: String
    var releaseDate: Date?
    var synopsis: String?
    var averageRating: Double?
    var ageRating: String?
    var posterImageURL: String?
    var coverImageURL: String?
    var thumbnail: Data?
    var duration: TimeInterval?
    var externalID: String
    var source: AnimeSources
    var creationDate: Date = .now
    
    var key: String {
        source.rawValue.description + externalID
    }
    
    static func < (lhs: SavedAnime, rhs: SavedAnime) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
    
    static func == (lhs: SavedAnime, rhs: SavedAnime) -> Bool {
        return lhs.title == rhs.title &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.synopsis == rhs.synopsis &&
        lhs.averageRating == rhs.averageRating &&
        lhs.ageRating == rhs.ageRating &&
        lhs.posterImageURL == rhs.posterImageURL &&
        lhs.coverImageURL == rhs.coverImageURL &&
        lhs.thumbnail == rhs.thumbnail &&
        lhs.duration == rhs.duration &&
        lhs.externalID == rhs.externalID &&
        lhs.source == rhs.source
    }
}
