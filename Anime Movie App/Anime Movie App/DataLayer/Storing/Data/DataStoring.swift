import Foundation

protocol DataStoring<KeyType, ValueType>: Storing {
    func object(forKey key: KeyType) -> Data?
    
    func setObject(_ obj: Data, forKey key: KeyType)
}
