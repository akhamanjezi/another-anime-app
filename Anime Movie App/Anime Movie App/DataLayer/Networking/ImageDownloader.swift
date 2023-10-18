import Foundation
import UIKit

class ImageDownloader: ImageDownloading {
    typealias ImageDownloadCompletionType = (Result<UIImage, LocalizedError>) -> ()
    private let storage: any ImageStoring<NSURL, UIImage>
    private var cachedCompletions = [NSURL: [ImageDownloadCompletionType]]()
    
    init(cache: any ImageStoring<NSURL, UIImage> = ImageCache.shared) {
        self.storage = cache
    }
    
    func downloadImage(from url: NSURL, completion: @escaping ImageDownloadCompletionType) {
        if anOngoingRequstSent(for: url) {
            cacheCompletion(completion, for: url)
            return
        }
        
        cacheCompletion(completion, for: url)
       
        let imageDataTask = dataTask(for: url) { result in
            switch result {
            case .success(let responseData):
                self.decodeAndConvert(responseData, from: url) { result in
                    completion(result)
                    return
                }
            case .failure(_):
                completion(.failure(.invalidResponse))
            }
        }
        imageDataTask.resume()
    }
    
    private func anOngoingRequstSent(for url: NSURL) -> Bool {
        return cachedCompletions[url] != nil
    }
    
    private func cacheCompletion(_ completion: @escaping ImageDownloadCompletionType, for url: NSURL) {
        if var completions = cachedCompletions[url] {
            completions.append(completion)
            cachedCompletions[url] = completions
        } else {
            cachedCompletions[url] = [completion]
        }
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
    
    private func decodeAndConvert(_ responseData: Data, from url: NSURL, completion: @escaping ImageDownloadCompletionType) {
        guard let image = UIImage(data: responseData), let blocks = self.cachedCompletions[url] else {
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
