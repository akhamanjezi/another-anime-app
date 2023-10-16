import Foundation

protocol AnimeRepository {
    func searchResults(for searchTerm: String, completion: @escaping ((Result<[Anime], LocalizedError>)) -> ())
    func anime(by id: String, completion: @escaping ((Result<Anime?, LocalizedError>)) -> ())
}
