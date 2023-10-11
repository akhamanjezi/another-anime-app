import Foundation

protocol DataProviding {
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ())
}
