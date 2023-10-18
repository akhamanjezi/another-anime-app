import Foundation
import UIKit

class SearchViewModel {
    private let animeRepository: AnimeRepository
    private let imageRepository: ImageRepository
    
    let numberOfSections = 1
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    var searchingError: Observable<LocalizedError?> = Observable(nil)
    var searchQueue = OperationQueue()
    private var currentSearchTerm = ""
    var dataSource: UITableViewDiffableDataSource<Section, Anime>! = nil
    
    init(animeRepository: AnimeRepository = KitsuRepository(), imageRepository: ImageRepository = ImageRepository()) {
        self.animeRepository = animeRepository
        self.imageRepository = imageRepository
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
    
    var resultCellProvider: UITableViewDiffableDataSource<Section, Anime>.CellProvider {
        return { [weak self]
            (tableView: UITableView, indexPath: IndexPath, item: Anime) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath)  as! SearchTableViewCell
            
            self?.downloadImage(from: NSURL(string: item.posterImageURL ?? "")!, for: item)
            cell.configureCell(for: item)
            return cell
        }
    }
    
    private func downloadImage(from url: NSURL, for item: Anime) {
        imageRepository.image(from: url, for: item) { [weak self] anime, image in
            self?.updateImageAndApplySnapshot(for: anime, with: image)
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
