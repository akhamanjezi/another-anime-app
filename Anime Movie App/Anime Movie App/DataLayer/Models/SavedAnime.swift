import Foundation

struct SavedAnime: Codable, Comparable {
    var title: String?
    var genres: [String]?
    var releaseDate: Date?
    var synopsis: String?
    var averageRating: Double?
    var ageRating: String?
    var posterImageURL: String?
    var coverImageURL: String?
    var thumbnail: Data?
    var duration: TimeInterval?
    var externalID: String?
    var source: AnimeSources?
    var creationDate: Date = .now
    
    var key: String {
        source.debugDescription + (externalID ?? "")
    }
    
    static func < (lhs: SavedAnime, rhs: SavedAnime) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
}
