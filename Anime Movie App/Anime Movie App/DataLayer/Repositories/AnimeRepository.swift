import UIKit

protocol AnimeRepository {
    typealias SearchResultsType = (term: String, results: [Anime])
    func searchResults(for searchTerm: String, completion: @escaping ((Result<(SearchResultsType), LocalizedError>)) -> ())
    func anime(by id: String, completion: @escaping ((Result<Anime, LocalizedError>)) -> ())
    func downloadImage(_ role: ImageRole, for anime: Anime, completion: @escaping (UIImage?) -> ())
}
