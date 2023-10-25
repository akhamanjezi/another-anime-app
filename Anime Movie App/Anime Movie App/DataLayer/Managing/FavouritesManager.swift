import Foundation

class FavouritesManager: FavouritesManaging {
    private let storage: any DataStoring<String, Data>
    private let mapper: any BidirectionalAnimeMapping<SavedAnime>
    
    var all: [Anime] {
        guard let favouritesDictionary = favouritesDictionary,
              let favorites = sortedValues(favouritesDictionary, by: >) else {
            return []
        }
        
        return convertToAnime(favorites)
    }
    
    init(storage: any DataStoring<String, Data> = FavouritesStorage.shared, mapper: any BidirectionalAnimeMapping<SavedAnime> = SavedAnimeToAnimeMapper()) {
        self.storage = storage
        self.mapper = mapper
        createDictionaryIfNotPresent()
    }
    
    func addFavourite(_ anime: Anime, forKey key: String) -> Bool {
        guard var favouritesDictionary = favouritesDictionary else {
            return false
        }
        
        favouritesDictionary[key] = mapper.mapFromAnime(anime)
        return setFavourites(favouritesDictionary)
    }
    
    func removeFavourite(_ anime: Anime, forKey key: String) -> Bool {
        guard var favouritesDictionary = favouritesDictionary else {
            return false
        }
        
        favouritesDictionary.removeValue(forKey: key)
        return setFavourites(favouritesDictionary)
    }
    
    func isFavourite(_ anime: Anime) -> Bool {
        all.contains(anime)
    }
    
    func resetFavourites() -> Bool {
        return setFavourites([:])
    }
    
    private func convertToAnime(_ saved: [SavedAnime]) -> [Anime] {
        return saved.compactMap { mapper.mapToAnime(from: $0) }
    }
    
    private func sortedValues(_ favouritesDictionary: [String: SavedAnime], by areInIncreasingOrder: (SavedAnime, SavedAnime) throws -> Bool) -> [SavedAnime]? {
        let favorites = favouritesDictionary.compactMap { $0.value }
        return try? favorites.sorted(by: areInIncreasingOrder)
    }
    
    private func createDictionaryIfNotPresent() {
        guard favouritesDictionary == nil else {
            return
        }
        
        let _ = resetFavourites()
    }
    
    private var favouritesDictionary: [String: SavedAnime]? {
        guard let data = storage.object(forKey: "favourites"),
              let favourites = try? JSONDecoder().decode([String: SavedAnime].self, from: data) else {
            return nil
        }
        
        return favourites
    }
    
    private func setFavourites(_ favouritesDictionary: [String: SavedAnime]) -> Bool {
        guard let objData = try? JSONEncoder().encode(favouritesDictionary) else {
            return false
        }
        
        storage.setObject(objData, forKey: "favourites")
        return true
    }
}
