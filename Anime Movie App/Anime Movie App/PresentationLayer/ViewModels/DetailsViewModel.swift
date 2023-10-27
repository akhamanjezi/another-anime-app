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
    
    var isFavourite: Bool {
        animeRepository.isFavourite(anime.value)
    }
    
    init(anime: Anime,
         animeRepository: AnimeRepository = KitsuRepository(),
         searchTerm: String? = nil) {
        self.anime.value = anime
        self.animeRepository = animeRepository
        self.searchTerm = searchTerm
        updatePosterImage()
    }
    
    func toggleFavourite(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).sync {
            self.animeRepository.toggleFavourite(self.anime.value)
            completion()
        }
    }
    
    private func updatePosterImage() {
        guard anime.value.posterImage == nil else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            animeRepository.downloadImage(.poster, for: self.anime.value) { [weak self] image in
                self?.setPosterImage(image)
            }
        }
    }
    
    private func setPosterImage(_ image: UIImage?) {
        anime.value.posterImage = image
        anime.value = anime.value
    }
}
