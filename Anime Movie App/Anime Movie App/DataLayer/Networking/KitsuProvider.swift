import Foundation

class KitsuProvider: DataProvider {
    
    static var shared = KitsuProvider()
    
    var baseURL: String {
        get {
            "https://kitsu.io/api/edge"
        }
    }
    
    var searchEndpoint: String {
        get {
            "/anime?filter[subtype]=movie&filter[text]="
        }
    }
    
    func search(for term: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: baseURL + searchEndpoint + term) else {
            completion(.failure(LocalizedError.invalidRequest))
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                completion(.failure(LocalizedError.invalidResponse))
                // TODO: retry failed request
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(.success(data))
                } else {
                    completion(.failure(LocalizedError.invalidResponse))
                    // TODO: retry failed request
                }
            }
        }
        task.resume()
    }
}
