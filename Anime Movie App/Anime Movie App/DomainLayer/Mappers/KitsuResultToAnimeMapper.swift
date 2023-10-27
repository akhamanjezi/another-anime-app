import Foundation

class KitsuResultToAnimeMapper: ToAnimeMapper {
    func mapToAnime(from kitsuResult: KitsuResult) -> Anime {
        let attributes = kitsuResult.attributes
        
        return Anime(title: attributes?.canonicalTitle,
                     genres: nil,
                     releaseDate: attributes?.startDate?.toDate(),
                     synopsis: attributes?.synopsis,
                     averageRating: attributes?.averageRating != nil ? Double(attributes!.averageRating!) : nil,
                     ageRating: attributes?.ageRating,
                     posterImageURL: attributes?.posterImage?.large ?? attributes?.posterImage?.original,
                     coverImageURL: attributes?.coverImage?.original ?? attributes?.posterImage?.original,
                     thumbnail: nil,
                     duration: 60 * Double((attributes?.totalLength ?? 0)),
                     externalID: kitsuResult.id,
                     source: .kitsu
        )
    }
}
