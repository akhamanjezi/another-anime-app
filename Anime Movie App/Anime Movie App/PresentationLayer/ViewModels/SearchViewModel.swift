import UIKit

class SearchViewModel {
    private let animeRepository: AnimeRepository
    private var currentSearchTerm = ""
    
    let numberOfSections = 1
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    var searchQueue = OperationQueue()
    var dataSource: UITableViewDiffableDataSource<Section, Anime>! = nil
    
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
    }
    
    func downloadImage(from url: NSURL, for item: Anime) {
        animeRepository.downloadImage(for: item) { [weak self] image in
            self?.updateImageAndApplySnapshot(for: item, with: image)
        }
    }
    
    private func updateImageAndApplySnapshot(for anime: Anime, with image: UIImage?) {
        guard let img = image, img != anime.posterImage else {
            return
        }
        
        var updatedSnapshot = dataSource.snapshot()
        
        guard let datasourceIndex = updatedSnapshot.indexOfItem(anime) else {
            return
        }
        
        guard let item = animeSearchResults.value[safe: datasourceIndex],
              item == anime else {
            return
        }
        
        item.posterImage = img
        
        updatedSnapshot.reloadItems([item])
        DispatchQueue.main.async {
            self.dataSource.apply(updatedSnapshot, animatingDifferences: false)
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
