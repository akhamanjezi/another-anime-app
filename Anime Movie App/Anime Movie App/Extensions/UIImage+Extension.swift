import UIKit

extension UIImage {
    static let defaultPlaceholder = UIImage(systemName: "popcorn.fill")?.applyingSymbolConfigurations([.Scale.large, .HierarchicalColor.placeholderText])
    
    static func == (lhs: UIImage, rhs: UIImage) -> Bool {
        lhs === rhs || lhs.pngData() == rhs.pngData()
    }
    
    func applyingSymbolConfigurations(_ configurations: [UIImage.SymbolConfiguration]) -> UIImage? {
        var baseImage: UIImage? = self
        for configuration in configurations {
            baseImage = baseImage?.applyingSymbolConfiguration(configuration)
        }
        return baseImage
    }
}
