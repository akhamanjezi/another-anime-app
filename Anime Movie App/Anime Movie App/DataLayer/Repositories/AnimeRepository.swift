import Foundation
import UIKit

protocol AnimeRepository {
    func searchResults(for searchTerm: String, completion: @escaping ((Result<[Anime], LocalizedError>)) -> ())
    func anime(by id: String, completion: @escaping ((Result<Anime?, LocalizedError>)) -> ())
    func downloadImage(for anime: Anime, completion: @escaping (UIImage?) -> ())
}
