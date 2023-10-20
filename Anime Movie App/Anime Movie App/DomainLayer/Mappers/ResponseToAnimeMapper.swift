import Foundation

protocol ResponseToAnimeMapping {
    associatedtype T
    
    func mapToAnime(from response: T) -> Anime?
}

protocol ResponseToAnimeMapper<T>: ResponseToAnimeMapping {
    func mapToAnime(from response: T) -> Anime?
}
