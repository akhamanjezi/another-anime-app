import Foundation

class DetailsViewModel {
    let anime: Anime
    let searchTerm: String
    var sections: [String] {
        anime.synopsis != nil ? ["Header", "Synopsis"] : ["Header"]
    }
    
    init(anime: Anime, searchTerm: String) {
        self.anime = anime
        self.searchTerm = searchTerm
    }
}
