import Foundation
import UIKit

class HomeViewModel {
    private let animeRepository: AnimeRepository
    private let imageRepository: ImageRepository
    
    var featureAnime: Observable<Anime?> = Observable(nil)
    var isFetching: Observable<Bool> = Observable(false)
    var fetchingError: Observable<LocalizedError?> = Observable(nil)
    var favourites: Observable<[Anime]> = Observable(Array(repeating: Anime.placeholder, count: 6))
    
    init(animeRepository: AnimeRepository, imageRepository: ImageRepository) {
        self.animeRepository = animeRepository
        self.imageRepository = imageRepository
    }
    
    func downloadImage(for anime: Anime) {
        guard let imageURL = anime.coverImageURL, let imageURL = NSURL(string: imageURL) else {
            return
        }
        imageRepository.image(from: imageURL, for: anime) { [weak self] anime, image in
            self?.handleSuccessfulFeatureImage(for: anime, with: image)
        }
    }
    
    func newFeatureAnime() {
        initiateFetching()
        
        animeRepository.anime(by: randomId) { [weak self] result in
            switch result {
            case .success(let anime):
                self?.handleSuccessfulFeatureDetails(for: anime ?? Anime.placeholder)
            case .failure(let error):
                self?.handleUnsuccessfulFeatureAnime(with: error)
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
    
    private func handleSuccessfulFeatureDetails(for anime: Anime) {
        featureAnime.value = anime
        downloadImage(for: anime)
    }
    
    private func handleUnsuccessfulFeatureAnime(with error: LocalizedError) {
        handleSuccessfulFeatureDetails(for: Anime.placeholder)
        isFetching.value = false
        fetchingError.value = error
    }
    
    private func handleSuccessfulFeatureImage(for anime: Anime, with image: UIImage?) {
        anime.coverImage = image
        self.featureAnime.value = anime
        self.isFetching.value = false
    }
}
