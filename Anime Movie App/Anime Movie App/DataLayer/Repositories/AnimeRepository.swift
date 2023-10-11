import Foundation

protocol AnimeRepository {
    func getSearchResults(for searchTerm: String, completion: @escaping ((Result<[Anime], LocalizedError>)) -> ())
}
