import Foundation

class HomeViewModel {
    let animeRepository: AnimeRepository
    var animeSearchResults: Observable<[Anime]> = Observable([])
    var isSearching: Observable<Bool> = Observable(false)
    
    init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func search(for searchTerm: String) {
        isSearching.value = true
        animeRepository.getSearchResults(for: searchTerm) { anime in
            self.animeSearchResults.value = anime ?? []
            self.isSearching.value = false
        }
    }
}
