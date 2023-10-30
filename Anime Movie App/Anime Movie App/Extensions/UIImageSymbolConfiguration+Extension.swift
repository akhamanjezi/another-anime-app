import UIKit

extension UIImage.SymbolConfiguration {
    struct HierarchicalColor {
        static let placeholderText = UIImage.SymbolConfiguration(hierarchicalColor: .placeholderText)
    }
    
    struct Scale {
        static let large = UIImage.SymbolConfiguration(scale: .large)
        static let medium = UIImage.SymbolConfiguration(scale: .medium)
    }
}
