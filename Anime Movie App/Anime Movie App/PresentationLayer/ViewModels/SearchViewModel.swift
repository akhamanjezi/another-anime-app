import UIKit

class SearchViewModel {
    private let animeRepository: AnimeRepository
    var currentSearchTerm = ""
    
    let numberOfSections = 1
    var animeSearchResults: Observable<[String: [Anime]]> = Observable(["":[]])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    var searchQueue = OperationQueue()
    
    
    init(animeRepository: AnimeRepository = KitsuRepository()) {
        self.animeRepository = animeRepository
    }
    
    func search(for searchTerm: String) {
        isSearching.value = true
        searchingError.value = nil
        currentSearchTerm = searchTerm.lowercased()
        
        guard nil == animeSearchResults.value[searchTerm.lowercased()] else {
            isSearching.value = false
            return
        }
        
        animeRepository.searchResults(for: searchTerm.lowercased()) { [weak self] result in
            switch result {
            case .success(let results):
                self?.updateSearchResults(results)
            case .failure(let error):
                self?.handleSearchingError(error)
            }
        }
    }
    
    func cancelSearch() {
        animeSearchResults.value = (["":[]])
        currentSearchTerm = ""
        searchingError.value = nil
        isSearching.value = false
    }
    
    func downloadImage(for item: Anime, completion: @escaping (UIImage?) -> ()) {
        animeRepository.downloadImage(.poster, for: item) { image in
            completion(image)
        }
    }
    
    private func updateSearchResults(_ search: AnimeRepository.SearchResultsType) {
        animeSearchResults.value[search.term] = search.results
        isSearching.value = false
    }
    
    private func handleSearchingError(_ error: LocalizedError? = nil) {
        updateSearchResults(("", []))
        searchingError.value = error
    }
}
