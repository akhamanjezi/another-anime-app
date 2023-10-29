import Foundation

class KitsuResultToAnimeMapper: ToAnimeMapper {
    func mapToAnime(from kitsuResult: KitsuResult) -> Anime? {
        guard let attributes = kitsuResult.attributes,
              let title = attributes.canonicalTitle,
              let externalID = kitsuResult.id else {
            return nil
        }
        
        return Anime(title: title,
                     releaseDate: attributes.startDate?.toDate(),
                     synopsis: attributes.synopsis,
                     averageRating: attributes.averageRating != nil ? Double(attributes.averageRating!) : nil,
                     ageRating: attributes.ageRating,
                     posterImageURL: attributes.posterImage?.large ?? attributes.posterImage?.original,
                     coverImageURL: attributes.coverImage?.original ?? attributes.posterImage?.original,
                     thumbnail: nil,
                     duration: 60 * Double((attributes.totalLength ?? 0)),
                     externalID: externalID,
                     source: .kitsu
        )
    }
}
