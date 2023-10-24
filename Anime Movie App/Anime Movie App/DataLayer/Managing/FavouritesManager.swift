import Foundation

class FavouritesManager: FavouritesManaging {
    private let storage: any DataStoring<String, Data>
    private let mapper: any ResponseToAnimeMapper<StoringAnime>
    
    var all: [Anime] {
        guard let favouritesDictionary = favouritesDictionary else {
            return []
        }
        
        let favorites = sortedValues(favouritesDictionary)
        
        return convertToAnime(favorites)
    }
    
    init(storage: any DataStoring<String, Data> = FavouritesStorage.shared, mapper: any ResponseToAnimeMapper<StoringAnime> = FavouriteToAnimeMapper()) {
        self.storage = storage
        self.mapper = mapper
        createDictionaryIfNotPresent()
    }
    
    func addFavourite(_ anime: Anime, forKey key: String) -> Bool {
        guard var favouritesDictionary = favouritesDictionary else {
            return false
        }
        
        favouritesDictionary[key] = StoringAnime(anime: anime)
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
    
    private func convertToAnime(_ saved: [StoringAnime]) -> [Anime] {
        return saved.compactMap { mapper.mapToAnime(from: $0) }
    }
    
    private func sortedValues(_ favouritesDictionary: [String: StoringAnime]) -> [StoringAnime] {
        let favorites = favouritesDictionary.compactMap { $0.value }
        return favorites
    }
    
    private func createDictionaryIfNotPresent() {
        guard favouritesDictionary == nil else {
            return
        }
        
        let _ = resetFavourites()
    }
    
    private var favouritesDictionary: [String: StoringAnime]? {
        guard let data = storage.object(forKey: "favourites"),
              let favourites = try? JSONDecoder().decode([String: StoringAnime].self, from: data) else {
            return nil
        }
        
        return favourites
    }
    
    private func setFavourites(_ favouritesDictionary: [String: StoringAnime]) -> Bool {
        guard let objData = try? JSONEncoder().encode(favouritesDictionary) else {
            return false
        }
        
        storage.setObject(objData, forKey: "favourites")
        return true
    }
}
