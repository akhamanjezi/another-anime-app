import UIKit

class ImageDownloader: ImageDownloading {
    typealias ImageDownloadCompletionType = (Result<UIImage, LocalizedError>) -> ()
    
    func downloadImage(from url: NSURL, completion: @escaping ImageDownloadCompletionType) {
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
        guard let image = UIImage(data: responseData) else {
            completion(.failure(.invalidResponse))
            return
        }
        
        completion(.success(image))
    }
}
