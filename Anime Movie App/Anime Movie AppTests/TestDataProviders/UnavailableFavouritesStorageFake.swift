import Foundation

class UnavailableFavouritesStorageFake: DataStoring {
    func object(forKey key: String) -> Data? {
        return nil
    }
    
    func setObject(_ obj: Data, forKey key: String) { }
}
