import UIKit

class DetailsViewModel {
    private let animeRepository: AnimeRepository
    let anime: Observable<Anime> = Observable(Anime.placeholder)
    let searchTerm: String?
    var sections: [String] {
        anime.value.synopsis != nil && !anime.value.synopsis!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? ["Header", "Synopsis"]
        : ["Header"]
    }
    
    var isFavorite: Bool {
        animeRepository.isFavourite(anime.value)
    }
    
    init(animeRepository: AnimeRepository = KitsuRepository(), anime: Anime, searchTerm: String? = nil) {
        self.animeRepository = animeRepository
        self.anime.value = anime
        self.searchTerm = searchTerm
        downloadImage(for: anime)
    }
    
    func toggleFavorite(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.animeRepository.toggleFavourite(self.anime.value)
            completion()
        }
    }
    
    private func downloadImage(for anime: Anime) {
        guard anime.posterImage == nil else {
            return
        }
        
        animeRepository.downloadImage(.poster, for: anime) { [weak self] image in
            self?.setPosterImage(for: anime, to: image)
        }
    }
    
    private func setPosterImage(for anime: Anime, to image: UIImage?) {
        anime.posterImage = image
        self.anime.value = anime
    }
}
