import Foundation

class HomeViewModel {
    private let animeRepository: AnimeRepository
    
    var featureAnime: Observable<Anime?> = Observable(nil)
    var isFetching: Observable<Bool> = Observable(false)
    var fetchingError: Observable<LocalizedError?> = Observable(nil)
    var favourites: Observable<[Anime]> = Observable(Array(repeating: Anime.placeholder, count: 6))
    
    init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func newFeatureAnime() {
        initiateFetching()
        
        animeRepository.anime(by: randomId) { [weak self] result in
            switch result {
            case .success(let anime):
                self?.handleSuccessfulFeature(anime)
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
    
    private func handleSuccessfulFeature(_ anime: Anime?) {
        featureAnime.value = (anime ?? Anime.placeholder)
        isFetching.value = false
    }
    
    private func handleUnsuccessfulFeatureAnime(with error: LocalizedError) {
        featureAnime.value = Anime.placeholder
        isFetching.value = false
        fetchingError.value = error
    }
}
