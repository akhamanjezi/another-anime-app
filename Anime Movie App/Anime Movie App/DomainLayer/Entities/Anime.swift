import UIKit

class Anime: Equatable, Hashable {
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
    var posterImage: UIImage?
    var coverImage: UIImage?
    
    var styledReleaseDate: String? {
        releaseDate?.toStringAnimeDateStyle()
    }
    
    var styledDuration: String? {
        guard let duration = duration,
                duration > 0 else {
            return nil
        }
        return DateComponentsFormatter.sharedBrief.string(from: duration)
    }
    
    var styledRating: String? {
        guard let averageRating = averageRating else {
            return nil
        }
        return (averageRating / 100).formatted(.percent)
    }
    
    init(title: String? = nil, genres: [String]? = nil, releaseDate: Date? = nil, synopsis: String? = nil, averageRating: Double? = nil, ageRating: String? = nil, posterImageURL: String? = nil, coverImageURL: String? = nil, thumbnail: Data? = nil, duration: TimeInterval? = nil, externalID: String? = nil, source: AnimeSources? = nil, posterImage: UIImage? = nil, coverImage: UIImage? = nil) {
        self.title = title
        self.genres = genres
        self.releaseDate = releaseDate
        self.synopsis = synopsis
        self.averageRating = averageRating
        self.ageRating = ageRating
        self.posterImageURL = posterImageURL
        self.coverImageURL = coverImageURL
        self.thumbnail = thumbnail
        self.duration = duration
        self.externalID = externalID
        self.source = source
        self.posterImage = posterImage
        self.coverImage = coverImage
    }
    
    static func == (lhs: Anime, rhs: Anime) -> Bool {
        return lhs.title == rhs.title &&
        lhs.genres == rhs.genres &&
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source.debugDescription + (externalID ?? ""))
    }
    
    static let placeholder = Anime(title: "Spirited Away",
                                   genres: nil,
                                   releaseDate: "2001-07-20".toDate(),
                                   synopsis: "Stubborn, spoiled, and naïve, 10-year-old Chihiro Ogino is less than pleased when she and her parents discover an abandoned amusement park on the way to their new house. Cautiously venturing inside, she realizes that there is more to this place than meets the eye, as strange things begin to happen once dusk falls. Ghostly apparitions and food that turns her parents into pigs are just the start—Chihiro has unwittingly crossed over into the spirit world. Now trapped, she must summon the courage to live and work amongst spirits, with the help of the enigmatic Haku and the cast of unique characters she meets along the way.\nVivid and intriguing, Sen to Chihiro no Kamikakushi tells the story of Chihiro's journey through an unfamiliar world as she strives to save her parents and return home.\n[Written by MAL Rewrite]",
                                   averageRating: 82.59,
                                   ageRating: "G",
                                   posterImageURL: "https://media.kitsu.io/anime/poster_images/176/large.jpg",
                                   coverImageURL: "https://media.kitsu.io/anime/cover_images/176/original.jpg",
                                   thumbnail: nil,
                                   duration: 7500,
                                   externalID: "176",
                                   source: .kitsu,
                                   posterImage: UIImage(named: "posterImage"),
                                   coverImage: UIImage(named: "coverImage"))
}
