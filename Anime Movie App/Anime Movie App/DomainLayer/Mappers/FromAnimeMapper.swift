import Foundation

protocol FromAnimeMapping {
    associatedtype T
    
    func mapFromAnime(_ anime: Anime) -> T
}

protocol FromAnimeMapper<T>: FromAnimeMapping {
    func mapFromAnime(_ anime: Anime) -> T
}
