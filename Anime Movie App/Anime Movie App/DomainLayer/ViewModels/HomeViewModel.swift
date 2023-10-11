import Foundation

class HomeViewModel {
    private let animeRepository: AnimeRepository
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    
    init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func search(for searchTerm: String) {
        isSearching.value = true
        animeRepository.getSearchResults(for: searchTerm) { result in
            switch result {
            case .success(let anime):
                self.updateSearchResults(with: anime)
            case .failure(_):
                self.updateSearchResults(with: [])
            }
        }
    }
    
    private func updateSearchResults(with anime: [Anime]) {
        self.animeSearchResults.value = anime
        self.isSearching.value = false
    }
}
