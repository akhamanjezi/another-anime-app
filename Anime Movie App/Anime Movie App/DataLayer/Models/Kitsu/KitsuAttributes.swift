import Foundation

class KitsuAttributes: Codable {
    let createdAt, updatedAt, slug, synopsis: String?
    let description: String?
    let coverImageTopOffset: Int?
    let titles: KitsuTitles?
    let canonicalTitle: String?
    let abbreviatedTitles: [String]?
    let averageRating: String?
    let ratingFrequencies: [String: String]?
    let userCount, favoritesCount: Int?
    let startDate, endDate: String?
    let nextRelease: JSONNull?
    let popularityRank, ratingRank: Int?
    let ageRating, ageRatingGuide, subtype, status: String?
    let tba: String?
    let posterImage, coverImage: KitsuImage?
    let episodeCount, episodeLength, totalLength: Int?
    let youtubeVideoID: String?
    let showType: String?
    let nsfw: Bool?

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, slug, synopsis, description, coverImageTopOffset, titles, canonicalTitle, abbreviatedTitles, averageRating, ratingFrequencies, userCount, favoritesCount, startDate, endDate, nextRelease, popularityRank, ratingRank, ageRating, ageRatingGuide, subtype, status, tba, posterImage, coverImage, episodeCount, episodeLength, totalLength
        case youtubeVideoID = "youtubeVideoId"
        case showType, nsfw
    }

    init(createdAt: String?, updatedAt: String?, slug: String?, synopsis: String?, description: String?, coverImageTopOffset: Int?, titles: KitsuTitles?, canonicalTitle: String?, abbreviatedTitles: [String]?, averageRating: String?, ratingFrequencies: [String: String]?, userCount: Int?, favoritesCount: Int?, startDate: String?, endDate: String?, nextRelease: JSONNull?, popularityRank: Int?, ratingRank: Int?, ageRating: String?, ageRatingGuide: String?, subtype: String?, status: String?, tba: String?, posterImage: KitsuImage?, coverImage: KitsuImage?, episodeCount: Int?, episodeLength: Int?, totalLength: Int?, youtubeVideoID: String?, showType: String?, nsfw: Bool?) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.slug = slug
        self.synopsis = synopsis
        self.description = description
        self.coverImageTopOffset = coverImageTopOffset
        self.titles = titles
        self.canonicalTitle = canonicalTitle
        self.abbreviatedTitles = abbreviatedTitles
        self.averageRating = averageRating
        self.ratingFrequencies = ratingFrequencies
        self.userCount = userCount
        self.favoritesCount = favoritesCount
        self.startDate = startDate
        self.endDate = endDate
        self.nextRelease = nextRelease
        self.popularityRank = popularityRank
        self.ratingRank = ratingRank
        self.ageRating = ageRating
        self.ageRatingGuide = ageRatingGuide
        self.subtype = subtype
        self.status = status
        self.tba = tba
        self.posterImage = posterImage
        self.coverImage = coverImage
        self.episodeCount = episodeCount
        self.episodeLength = episodeLength
        self.totalLength = totalLength
        self.youtubeVideoID = youtubeVideoID
        self.showType = showType
        self.nsfw = nsfw
    }
}
