import Foundation
import UIKit

protocol ImageStoring<KeyType, ValueType>: Storing {
    func object(forKey key: KeyType) -> UIImage?
    
    func setObject(_ obj: UIImage, forKey key: KeyType)
}
