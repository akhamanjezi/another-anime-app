import UIKit

extension UIButton.Configuration {
    static var reloadBorderless: UIButton.Configuration {
        var borderlessButtonConfig = UIButton.Configuration.borderless()
        borderlessButtonConfig.image = UIImage(systemName: "arrow.clockwise")
        return borderlessButtonConfig
    }
    
    static var loadingBorderless: UIButton.Configuration {
        var borderlessButtonConfig = UIButton.Configuration.borderless()
        borderlessButtonConfig.showsActivityIndicator = true
        return borderlessButtonConfig
    }
}
