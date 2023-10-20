import Foundation

class DetailsViewModel {
    let anime: Anime
    var sections: [String] {
        anime.synopsis != nil ? ["Header", "Synopsis"] : ["Header"]
    }
    
    init(anime: Anime) {
        self.anime = anime
    }
}
