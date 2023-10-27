import Foundation

protocol ToAnimeMapping {
    associatedtype T
    
    func mapToAnime(from response: T) -> Anime
}

protocol ToAnimeMapper<T>: ToAnimeMapping {
    func mapToAnime(from response: T) -> Anime
}
