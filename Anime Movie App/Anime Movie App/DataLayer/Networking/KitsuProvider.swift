import Foundation

class KitsuProvider: DataProviding {
    private let baseURL = "https://kitsu.io/api/edge"
    private let baseSearchEndpoint = "/anime?filter[subtype]=movie&filter[text]="
    
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ()) {
        guard let searchRequest = urlRequest(for: baseSearchEndpoint + term) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let searchDataTask = dataTask(for: searchRequest) { result in
            completion(result)
        }
        
        searchDataTask.resume()
    }
    
    private func urlRequest(for endpoint: String) -> URLRequest? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        
        return URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
    }
    
    private func dataTask(for request: URLRequest, completion: @escaping (Result<Data, LocalizedError>) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
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
}
