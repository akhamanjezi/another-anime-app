import UIKit

class HomeViewModel {
    private let animeRepository: AnimeRepository
    
    var featureAnime: Observable<Anime?> = Observable(nil)
    var isFetching: Observable<Bool> = Observable(false)
    var fetchingError: Observable<LocalizedError?> = Observable(nil)
    var favourites: Observable<[Anime]> = Observable(Array(repeating: Anime.placeholder, count: 6))
    
    init(animeRepository: AnimeRepository = KitsuRepository()) {
        self.animeRepository = animeRepository
    }
    
    func newFeatureAnime() {
        initiateFetching()
        
        animeRepository.anime(by: randomId) { [weak self] result in
            switch result {
            case .success(let anime):
                self?.updateDetailsAndDownloadImage(for: anime)
            case .failure(let error):
                self?.resetFeatureAnime(with: error)
            }
        }
    }
    
    private var randomId: String {
        Int.random(in: 0...10000).description
    }
    
    private func initiateFetching() {
        isFetching.value = true
        fetchingError.value = nil
    }
    
    private func updateDetailsAndDownloadImage(for anime: Anime) {
        featureAnime.value = anime
        downloadImage(for: anime)
    }
    
    private func downloadImage(for anime: Anime) {
        animeRepository.downloadImage(.poster, for: anime) { [weak self] image in
            self?.setCoverImage(for: anime, to: image)
        }
    }
    
    private func resetFeatureAnime(with error: LocalizedError) {
        updateDetailsAndDownloadImage(for: Anime.placeholder)
        isFetching.value = false
        fetchingError.value = error
    }
    
    private func setCoverImage(for anime: Anime, to image: UIImage?) {
        anime.coverImage = image
        self.featureAnime.value = anime
        self.isFetching.value = false
    }
}
