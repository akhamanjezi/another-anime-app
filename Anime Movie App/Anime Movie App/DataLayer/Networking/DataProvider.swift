import Foundation

protocol DataProvider {
    
    var baseURL: String {
        get
    }
    
    var searchEndpoint: String {
        get
    }
    
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ())
}
