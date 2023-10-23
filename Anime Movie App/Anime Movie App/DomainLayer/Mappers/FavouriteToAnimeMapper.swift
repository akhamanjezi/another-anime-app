import UIKit

class FavouriteToAnimeMapper: ResponseToAnimeMapper {
    func mapToAnime(from favourite: StoringAnime) -> Anime? {
        let posterImage = favourite.posterImageData == nil
        ? nil
        : UIImage(data: favourite.posterImageData!)
        
        let coverImage = favourite.coverImageData == nil
        ? nil
        : UIImage(data: favourite.coverImageData!)
        
        return Anime(title: favourite.title,
                     genres: favourite.genres,
                     releaseDate: favourite.releaseDate,
                     synopsis: favourite.synopsis,
                     averageRating: favourite.averageRating,
                     ageRating: favourite.ageRating,
                     posterImageURL: favourite.posterImageURL,
                     coverImageURL: favourite.coverImageURL,
                     thumbnail: favourite.thumbnail,
                     duration: favourite.duration,
                     externalID: favourite.externalID,
                     source: favourite.source,
                     posterImage: posterImage,
                     coverImage: coverImage
        )
    }
}
