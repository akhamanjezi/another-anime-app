import Foundation

class TestDataStorage: DataStoring {
    private let storage = NSCache<NSString, NSData>()
        
    func object(forKey key: String) -> Data? {
        guard let nsdata = storage.object(forKey: NSString(string: key)) else {
            return nil
        }
        return Data(referencing: nsdata)
    }
    
    func setObject(_ obj: Data, forKey key: String) {
        storage.setObject(NSData(data: obj), forKey: NSString(string: key))
    }
}
