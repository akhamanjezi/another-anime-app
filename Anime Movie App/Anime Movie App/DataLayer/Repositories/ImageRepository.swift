import Foundation
import UIKit

class ImageRepository {
    private let imageDownloder: ImageDownloading
    private let storage: any ImageStoring<NSURL, UIImage>
    
    init(imageDownloder: ImageDownloading = ImageDownloader(), storage: any ImageStoring<NSURL, UIImage> = ImageCache.shared) {
        self.imageDownloder = imageDownloder
        self.storage = storage
    }
    
    func image(from url: NSURL, for anime: Anime, completion: @escaping (Anime, UIImage?) -> ()) {
        if let cachedImage = imageFromCache(with: url) {
            DispatchQueue.main.async {
                completion(anime, cachedImage)
            }
            return
        }
        
        imageDownloder.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                self.storage.setObject(image, forKey: url)
                completion(anime, image)
            case .failure(_):
                completion(anime, UIImage(systemName: "popcorn.circle"))
            }
        }
    }
    
    private func imageFromCache(with url: NSURL) -> UIImage? {
        return storage.object(forKey: url)
    }
}
