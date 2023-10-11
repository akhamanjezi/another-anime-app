import Foundation

protocol DataProvider {
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ())
}
