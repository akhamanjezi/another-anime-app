import Foundation

class KitsuResultToAnimeMapper: ResponseToAnimeMapper {
    func mapToAnime(from response: KitsuResult) -> Anime? {
        guard let attributes = response.attributes else {
            return nil
        }
                
        return Anime(title: attributes.canonicalTitle,
                     genres: nil,
                     releaseDate: attributes.startDate?.toDate(),
                     synopsis: attributes.synopsis,
                     averageRating: attributes.averageRating != nil ? Double(attributes.averageRating!) : nil,
                     ageRating: attributes.ageRating,
                     imageURL: attributes.posterImage?.original,
                     thumnail: nil,
                     duration: .seconds(60) * (attributes.totalLength ?? 0),
                     externalID: response.id,
                     source: .kitsu
        )
    }
}
