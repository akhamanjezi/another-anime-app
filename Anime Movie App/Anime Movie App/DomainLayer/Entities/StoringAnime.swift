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
    var posterImageData: Data?
    var coverImageData: Data?
    var creationDate: Date?
    
    init(anime: Anime) {
        title = anime.title
        genres = anime.genres
        releaseDate = anime.releaseDate
        synopsis = anime.synopsis
        averageRating = anime.averageRating
        ageRating = anime.ageRating
        posterImageURL = anime.posterImageURL
        coverImageURL = anime.coverImageURL
        thumbnail = anime.thumbnail
        duration = anime.duration
        externalID = anime.externalID
        source = anime.source
        posterImageData = anime.posterImage?.pngData()
        coverImageData = anime.coverImage?.pngData()
        creationDate = .now
    }
    
    static func <(lhs: StoringAnime, rhs: StoringAnime) -> Bool {
        lhs.creationDate ?? .distantPast < rhs.creationDate ?? .distantPast
    }
}
