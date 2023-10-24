import Foundation

struct StoringAnime: Codable, Comparable {
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
    var creationDate: Date?
    
    var key: String {
        source.debugDescription + (externalID ?? "")
    }
    
    init(anime: Anime, creationDate: Date = .now) {
        title = anime.title
        genres = anime.genres
        releaseDate = anime.releaseDate
        synopsis = anime.synopsis
        averageRating = anime.averageRating
        ageRating = anime.ageRating
        posterImageURL = anime.posterImageURL
        coverImageURL = anime.coverImageURL
        thumbnail = anime.posterImage?.jpegData(compressionQuality: 0)
        duration = anime.duration
        externalID = anime.externalID
        source = anime.source
        self.creationDate = creationDate
    }
    
    static func < (lhs: StoringAnime, rhs: StoringAnime) -> Bool {
        lhs.creationDate ?? .distantPast < rhs.creationDate ?? .distantPast
    }
}
