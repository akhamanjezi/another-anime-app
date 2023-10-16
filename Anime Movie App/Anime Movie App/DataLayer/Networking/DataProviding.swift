import Foundation

protocol DataProviding {
    func search(for term: String, completion: @escaping (Result<Data, LocalizedError>) -> ())
    func getAnime(by id: String, completion: @escaping (Result<Data, LocalizedError>) -> ())
}
