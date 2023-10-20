import UIKit

class ImageDownloaderStub: ImageDownloading {
    func downloadImage(from url: NSURL, completion: @escaping (Result<UIImage, LocalizedError>) -> ()) {
        if url.absoluteString!.contains("poster") {
            completion(.success(UIImage(named: "posterImage", in: Bundle(for: ImageDownloaderStub.self), with: nil)!))
            return
        } else if url.absoluteString!.contains("cover") {
            completion(.success(UIImage(named: "coverImage", in: Bundle(for: ImageDownloaderStub.self), with: nil)!))
            return
        }
        
        completion(.failure(.invalidResponse))
    }
}
