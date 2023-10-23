import Foundation

protocol FavouritesManaging {
    var all: [Anime] { get }
    
    func addFavourite(_ anime: Anime, forKey key: String)
    
    func removeFavourite(_ anime: Anime, forKey key: String)
    
    func isFavourite(_ anime: Anime) -> Bool
    
    func resetFavourites()
}
