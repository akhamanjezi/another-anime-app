import Foundation
import UIKit

class ImageDownloader: ImageDownloading {
    typealias ImageDownloadCompletionType = (Result<UIImage, LocalizedError>) -> ()
    private let storage: any ImageStoring<NSURL, UIImage>
    private var loadingResponses = [NSURL: [ImageDownloadCompletionType]]()
    
    init(cache: any ImageStoring<NSURL, UIImage> = ImageCache.shared) {
        self.storage = cache
    }
    
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
    func downloadImage(from url: NSURL, completion: @escaping ImageDownloadCompletionType) {
            return
        } else {
            loadingResponses[url] = [completion]
        }
       
        let imageDataTask = dataTask(for: url) { result in
            switch result {
            case .success(let responseData):
                self.decodeAndConvertResponse(from: url, with: responseData) { result in
                    completion(result)
                    return
                }
            case .failure(_):
                completion(.failure(.invalidResponse))
            }
        }
        imageDataTask.resume()
    }
    
    private func dataTask(for url: NSURL, completion: @escaping (Result<Data, LocalizedError>) -> ()) ->
        URLSessionDataTask {
        return URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(data))
        }
    }
    
        guard let image = UIImage(data: responseData), let blocks = self.loadingResponses[url] else {
    private func decodeAndConvertResponse(from url: NSURL, with responseData: Data, completion: @escaping ImageDownloadCompletionType) {
            completion(.failure(.invalidResponse))
            return
        }
                
        for block in blocks {
            DispatchQueue.main.async {
                block(.success(image))
            }
            return
        }
    }
}
