import Foundation

protocol AnimeRepository {
    func searchResults(for searchTerm: String, completion: @escaping ((Result<[Anime], LocalizedError>)) -> ())
}
