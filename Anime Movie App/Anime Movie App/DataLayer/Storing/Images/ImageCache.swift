import UIKit

class ImageCache: ImageStoring {
    private let cache: NSCache<NSURL, UIImage>
    
    init(cache: NSCache<NSURL, UIImage>) {
        self.cache = cache
    }
    
    func object(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func setObject(_ obj: UIImage, forKey key: NSURL) {
        cache.setObject(obj, forKey: key)
    }
}
