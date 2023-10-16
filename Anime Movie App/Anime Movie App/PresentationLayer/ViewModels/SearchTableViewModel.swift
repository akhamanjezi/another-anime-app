import Foundation

class SearchTableViewModel {
    private let animeRepository: AnimeRepository
    let numberOfSections = 1
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    var searchQueue = OperationQueue()
    var currentSearchTerm = ""
    
    init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func search(for searchTerm: String) {
        isSearching.value = true
        searchingError.value = nil
        currentSearchTerm = searchTerm
        
        animeRepository.searchResults(for: searchTerm) { [weak self] result in
            guard self?.currentSearchTerm == searchTerm else {
                return
            }
            
            switch result {
            case .success(let anime):
                self?.updateSearchResults(with: anime)
            case .failure(let error):
                self?.handleSearchingError(error)
            }
        }
    }
    
    func cancelSearch() {
        self.isSearching.value = false
        self.animeSearchResults.value = []
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
