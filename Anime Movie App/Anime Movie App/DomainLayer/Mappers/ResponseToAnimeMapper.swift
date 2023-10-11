import Foundation

protocol ResponseToAnimeMapping {
    associatedtype T
    
    func mapToAnime(from response: T) -> Anime?
}

class ResponseToAnimeMapper<T>: ResponseToAnimeMapping {
    func mapToAnime(from response: T) -> Anime? {
        return nil
    }
}
