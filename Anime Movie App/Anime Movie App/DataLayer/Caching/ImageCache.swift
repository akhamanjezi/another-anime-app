import UIKit

class ImageCache: ImageStoring {
    public static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() { }
    
    func object(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func setObject(_ obj: UIImage, forKey key: NSURL) {
        cache.setObject(obj, forKey: key)
    }
}
