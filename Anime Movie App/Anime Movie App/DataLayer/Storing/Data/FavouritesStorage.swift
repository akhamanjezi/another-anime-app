import Foundation

class FavouritesStorage: DataStoring {
    private let storage: UserDefaults
    
    init(storage: UserDefaults) {
        self.storage = storage
    }
    
    func object(forKey key: String) -> Data? {
        return storage.data(forKey: key)
    }
    
    func setObject(_ obj: Data, forKey key: String) {
        storage.set(obj, forKey: key)
    }
}
