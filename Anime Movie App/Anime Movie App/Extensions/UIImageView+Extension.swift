import UIKit

extension UIImageView {
    func configureWith(image: UIImage?, contentMode: UIImageView.ContentMode) {
        self.image = image
        self.contentMode = contentMode
    }
}
