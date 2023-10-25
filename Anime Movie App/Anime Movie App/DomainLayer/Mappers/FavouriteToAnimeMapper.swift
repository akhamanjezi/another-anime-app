import UIKit

class FavouriteToAnimeMapper: ResponseToAnimeMapper {
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
