import Foundation

class DataProviderStub: DataProviding {
    private let resourcePath: String
    
    init(resourcePath: String) {
        self.resourcePath = resourcePath
    }
    
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ()) {
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: resourcePath) {
            completion(.failure(.invalidRequest))
            return
        }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: resourcePath), options: .mappedIfSafe) {
            completion(.success(data))
        } else {
            completion(.failure(.invalidResponse))
        }
    }
}
