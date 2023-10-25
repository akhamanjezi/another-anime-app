import Foundation

protocol FavouritesManaging {
    var all: [Anime] { get }
    func addFavourite(_ anime: Anime, forKey key: String) -> Bool
    func removeFavourite(_ anime: Anime, forKey key: String) -> Bool
    func isFavourite(_ anime: Anime) -> Bool
    func resetFavourites() -> Bool
}
