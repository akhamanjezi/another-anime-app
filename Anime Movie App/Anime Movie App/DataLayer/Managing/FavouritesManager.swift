import Foundation

class FavouritesManager: FavouritesManaging {
    private let storage: any DataStoring<String, Data>
    private let mapper: any ResponseToAnimeMapper<StoringAnime>
    
    var all: [Anime] {
        guard let favouritesDictionary = favouritesDictionary else {
            return []
        }
        
        let favorites = favouritesDictionary.compactMap { $0.value }
        
        return favorites.sorted(by: >).compactMap { mapper.mapToAnime(from: $0) }
    }
    
    init(storage: any DataStoring<String, Data> = FavouritesStorage.shared, mapper: any ResponseToAnimeMapper<StoringAnime> = FavouriteToAnimeMapper()) {
        self.storage = storage
        self.mapper = mapper
        createDictionaryIfNotPresent()
    }
    
    func addFavourite(_ anime: Anime, forKey key: String) {
        guard var favouritesDictionary = favouritesDictionary else {
            return
        }
        
        favouritesDictionary[key] = StoringAnime(anime: anime)
        setFavourites(favouritesDictionary)
    }
    
    func removeFavourite(_ anime: Anime, forKey key: String) {
        guard var favouritesDictionary = favouritesDictionary else {
            return
        }
        
        favouritesDictionary.removeValue(forKey: key)
        setFavourites(favouritesDictionary)
    }
    
    func isFavourite(_ anime: Anime) -> Bool {
        all.contains(anime)
    }
    
    func resetFavourites() {
        setFavourites([:])
    }
    
    private func createDictionaryIfNotPresent() {
        guard let _ = storage.object(forKey: "favourites") else {
            let favouritesDictionary: [String: StoringAnime] = [:]
            guard let objData = try? JSONEncoder().encode(favouritesDictionary) else {
                return
            }
            storage.setObject(objData, forKey: "favourites")
            return
        }
    }
    
    private var favouritesDictionary: [String: StoringAnime]? {
        guard let data = storage.object(forKey: "favourites"),
              let favourites = try? JSONDecoder().decode([String: StoringAnime].self, from: data) else {
            return nil
        }
        
        return favourites
    }
    
    private func setFavourites(_ favouritesDictionary: [String: StoringAnime]) {
        guard let objData = try? JSONEncoder().encode(favouritesDictionary) else {
            return
        }
        
        storage.setObject(objData, forKey: "favourites")
    }
}
