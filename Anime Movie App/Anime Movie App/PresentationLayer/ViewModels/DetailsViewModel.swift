import Foundation

class DetailsViewModel {
    let anime: Observable<Anime> = Observable(Anime.placeholder)
    let searchTerm: String?
    var sections: [String] {
        anime.value.synopsis != nil ? ["Header", "Synopsis"] : ["Header"]
    }
    
    init(anime: Anime, searchTerm: String? = nil) {
        self.anime.value = anime
        self.searchTerm = searchTerm
    }
}
