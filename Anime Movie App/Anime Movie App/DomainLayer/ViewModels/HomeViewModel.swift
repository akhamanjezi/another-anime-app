import Foundation

class HomeViewModel {
    private let animeRepository: AnimeRepository
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    
    init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func search(for searchTerm: String) {
        isSearching.value = true
        searchingError.value = nil
        
        animeRepository.getSearchResults(for: searchTerm) { result in
            switch result {
            case .success(let anime):
                self.updateSearchResults(with: anime)
            case .failure(let error):
                self.handleSearchingError(error)
            }
        }
    }
    
    private func updateSearchResults(with anime: [Anime]) {
        self.animeSearchResults.value = anime
        self.isSearching.value = false
    }
    
    private func handleSearchingError(_ error: LocalizedError? = nil) {
        self.updateSearchResults(with: [])
        self.searchingError.value = error
    }
}
