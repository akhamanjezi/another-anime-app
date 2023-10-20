import UIKit

extension UIFont {
    static var headingBold: UIFont {
        UIFont.preferredFont(forTextStyle: .title2).with(weight: .bold).rounded()
    }
    
    static var subHeadingMedium: UIFont {
        UIFont.preferredFont(forTextStyle: .callout).with(weight: .medium).rounded()
    }
    
    static var roundedCallout: UIFont {
        UIFont.preferredFont(forTextStyle: .callout).with(weight: .regular).rounded()
    }
    
    static var roundedCaption2: UIFont {
        UIFont.preferredFont(forTextStyle: .caption2).with(weight: .regular).rounded()
    }
    
    static var roundedCaption2Bold: UIFont {
        UIFont.preferredFont(forTextStyle: .caption2).with(weight: .bold).rounded()
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
