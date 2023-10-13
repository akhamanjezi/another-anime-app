import UIKit

extension UIFont {
    static var sectionTitle: UIFont {
        UIFont.preferredFont(forTextStyle: .title2).with(weight: .bold).rounded()
    }
    
    static var featureTitle: UIFont {
        UIFont.preferredFont(forTextStyle: .callout).with(weight: .medium).rounded()
    }
    
    static var cellTitle: UIFont {
        UIFont.preferredFont(forTextStyle: .callout).with(weight: .regular).rounded()
    }
    
    static var cellSubtitle: UIFont {
        UIFont.preferredFont(forTextStyle: .caption2).with(weight: .regular).rounded()
    }
    
    static var roundedLargeTitle: UIFont {
        UIFont.preferredFont(forTextStyle: .largeTitle).with(weight: .bold).rounded()
    }
    
    private func with(weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
    
    private func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
