import UIKit

class ImageRepo: ImageRepository {
    private let imageDownloader: ImageDownloading
    private let storage: any ImageStoring<NSURL, UIImage>
    
    init(imageDownloader: ImageDownloading = ImageDownloader(), storage: any ImageStoring<NSURL, UIImage> = ImageCache.shared) {
        self.imageDownloader = imageDownloader
        self.storage = storage
    }
    
    func image(from url: NSURL, for anime: Anime, completion: @escaping (Anime, UIImage?) -> ()) {
        if let cachedImage = imageFromCache(with: url) {
            completion(anime, cachedImage)
            return
        }
        
        imageDownloader.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.storage.setObject(image, forKey: url)
                completion(anime, image)
            case .failure(_):
                completion(anime, nil)
            }
        }
    }
    
    private func imageFromCache(with url: NSURL) -> UIImage? {
        return storage.object(forKey: url)
    }
}
