import UIKit

class SearchViewModel {
    private let animeRepository: AnimeRepository
    private var currentSearchTerm = ""
    
    let numberOfSections = 1
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    var searchQueue = OperationQueue()
    
    
    init(animeRepository: AnimeRepository = KitsuRepository()) {
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
        updateSearchResults(with: [])
        searchingError.value = nil
        isSearching.value = false
    }
    
    func downloadImage(from url: NSURL, for item: Anime, completion: @escaping (UIImage?) -> ()) {
        animeRepository.downloadImage(for: item) { [weak self] image in
            completion(image)
        }
    }
    
    private func updateSearchResults(with anime: [Anime]) {
        animeSearchResults.value = anime
        isSearching.value = false
    }
    
    private func handleSearchingError(_ error: LocalizedError? = nil) {
        updateSearchResults(with: [])
        searchingError.value = error
    }
}
