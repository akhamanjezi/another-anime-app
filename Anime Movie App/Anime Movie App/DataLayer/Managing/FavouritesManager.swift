import Foundation

class FavouritesManager: FavouritesManaging {
    private let storage: any DataStoring<String, Data>
    private let mapper: any BidirectionalAnimeMapping<SavedAnime>
    
    var all: [Anime] {
        guard let favouritesDictionary = favouritesDictionary,
              let favourites = sortedValues(favouritesDictionary) else {
            return []
        }
        
        return convertToAnime(favourites)
    }
    
    init(storage: any DataStoring<String, Data> = FavouritesStorage.shared, 
         mapper: any BidirectionalAnimeMapping<SavedAnime> = SavedAnimeToAnimeMapper()) {
        self.storage = storage
        self.mapper = mapper
        createDictionaryIfNotPresent()
    }
    
    func addFavourite(_ anime: Anime, forKey key: String) {
        guard var favouritesDictionary = favouritesDictionary else {
            return
        }
        
        favouritesDictionary[key] = mapper.mapFromAnime(anime)
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
    
    private func convertToAnime(_ saved: [SavedAnime]) -> [Anime] {
        return saved.compactMap { mapper.mapToAnime(from: $0) }
    }
    
    private func sortedValues(_ favouritesDictionary: [String: SavedAnime]) -> [SavedAnime]? {
        let favourites = favouritesDictionary.compactMap { $0.value }
        return favourites.sorted(by: >)
    }
    
    private func createDictionaryIfNotPresent() {
        guard favouritesDictionary == nil else {
            return
        }
        
        resetFavourites()
    }
    
    private var favouritesDictionary: [String: SavedAnime]? {
        guard let data = storage.object(forKey: "favourites"),
              let favourites = try? JSONDecoder().decode([String: SavedAnime].self, from: data) else {
            return nil
        }
        
        return favourites
    }
    
    private func setFavourites(_ favouritesDictionary: [String: SavedAnime]) {
        guard let objData = try? JSONEncoder().encode(favouritesDictionary) else {
            return
        }
        
        storage.setObject(objData, forKey: "favourites")
    }
}
