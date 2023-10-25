import UIKit

class FavouriteToAnimeMapper: BidirectionalAnimeMapping {
    func mapFromAnime(_ anime: Anime) -> SavedAnime? {
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
    
    func mapToAnime(from favourite: SavedAnime) -> Anime? {
        let thumbnail = favourite.thumbnail == nil
        ? nil
        : UIImage(data: favourite.thumbnail!)
        
        return Anime(title: favourite.title,
                     genres: favourite.genres,
                     releaseDate: favourite.releaseDate,
                     synopsis: favourite.synopsis,
                     averageRating: favourite.averageRating,
                     ageRating: favourite.ageRating,
                     posterImageURL: favourite.posterImageURL,
                     coverImageURL: favourite.coverImageURL,
                     thumbnail: thumbnail,
                     duration: favourite.duration,
                     externalID: favourite.externalID,
                     source: favourite.source)
    }
}
