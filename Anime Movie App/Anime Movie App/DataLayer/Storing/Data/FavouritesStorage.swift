import Foundation

class FavouritesStorage: DataStoring {
    static let shared = FavouritesStorage()
    private let storage = UserDefaults.standard
    
    private init() { }
    
    func object(forKey key: String) -> Data? {
        return storage.data(forKey: key)
    }
    
    func setObject(_ obj: Data, forKey key: String) {
        storage.set(obj, forKey: key)
    }
}
