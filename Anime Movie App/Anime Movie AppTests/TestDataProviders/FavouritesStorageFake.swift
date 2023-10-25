import Foundation

class FavouritesStorageFake: DataStoring {
    private var storage: [String: SavedAnime]?
    
    init(storage: [String : SavedAnime]? = [:]) {
        self.storage = storage
    }
    
    func object(forKey _: String) -> Data? {
        return try? JSONEncoder().encode(storage)
    }
    
    func setObject(_ obj: Data, forKey _: String) {
        guard let data = try? JSONDecoder().decode([String: SavedAnime].self, from: obj) else {
            return
        }
        storage = data
    }
}
