import Foundation
import UIKit

protocol Storing {
    associatedtype KeyType
    associatedtype ValueType
    
    func object(forKey key: KeyType) -> ValueType?
    func setObject(_ obj: ValueType, forKey key: KeyType)
}
