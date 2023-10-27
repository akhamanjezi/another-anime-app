import UIKit

class SavedAnimeToAnimeMapper: BidirectionalAnimeMapping {
    func mapFromAnime(_ anime: Anime) -> SavedAnime {
        SavedAnime(title: anime.title,
                   genres: anime.genres,
                   releaseDate: anime.releaseDate,
                   synopsis: anime.synopsis,
                   averageRating: anime.averageRating,
                   ageRating: anime.ageRating,
                   posterImageURL: anime.posterImageURL,
                   coverImageURL: anime.coverImageURL,
                   thumbnail: anime.posterImage?.jpegData(compressionQuality: 0),
                   duration: anime.duration,
                   externalID: anime.externalID,
                   source: anime.source,
                   creationDate: .now)
    }
    
    func mapToAnime(from savedAnime: SavedAnime) -> Anime? {
        let thumbnail = savedAnime.thumbnail == nil
        ? nil
        : UIImage(data: savedAnime.thumbnail!)
        
        return Anime(title: savedAnime.title,
                     genres: savedAnime.genres,
                     releaseDate: savedAnime.releaseDate,
                     synopsis: savedAnime.synopsis,
                     averageRating: savedAnime.averageRating,
                     ageRating: savedAnime.ageRating,
                     posterImageURL: savedAnime.posterImageURL,
                     coverImageURL: savedAnime.coverImageURL,
                     thumbnail: thumbnail,
                     duration: savedAnime.duration,
                     externalID: savedAnime.externalID,
                     source: savedAnime.source)
    }
}
