import UIKit

class DetailsViewModel {
    private let animeRepository: AnimeRepository
    let anime: Observable<Anime> = Observable(Anime.placeholder)
    let searchTerm: String?
    var sections: [String] {
        anime.value.synopsis != nil && !(anime.value.synopsis ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? ["Header", "Synopsis"]
        : ["Header"]
    }
    
    init(animeRepository: AnimeRepository = KitsuRepository(), anime: Anime, searchTerm: String? = nil) {
        self.animeRepository = animeRepository
        self.anime.value = anime
        self.searchTerm = searchTerm
        
        if anime.posterImage == nil {
            downloadImage(for: anime)
        }
    }
    
    private func downloadImage(for anime: Anime) {
        animeRepository.downloadImage(.poster, for: anime) { [weak self] image in
            self?.setPosterImage(for: anime, to: image)
        }
    }
    
    private func setPosterImage(for anime: Anime, to image: UIImage?) {
        anime.posterImage = image
        self.anime.value = anime
    }
}
