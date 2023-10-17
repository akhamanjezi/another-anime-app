import UIKit

extension UIImage {
    static func ==(lhs: UIImage, rhs: UIImage) -> Bool {
        lhs === rhs || lhs.pngData() == rhs.pngData()
    }
}
