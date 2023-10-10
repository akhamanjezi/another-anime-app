import Foundation

protocol AnimeRepository {
    func getSearchResults(for searchTerm: String, completion: @escaping ([Anime]?) -> ())
}
