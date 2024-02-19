import UIKit
import NeedleFoundation

protocol DetailsDependency: Dependency {
    var animeRepository: AnimeRepository { get }
}

class DetailsComponent: Component<DetailsDependency>, DetailsBuilder {
    private let anime: Anime
    private let searchTerm: String?
    
    init(
        parent: Scope, anime: Anime,
        searchTerm: String? = nil
    ) {
        self.anime = anime
        self.searchTerm = searchTerm
        super.init(parent: parent)
    }
    
    var detailsViewController: UIViewController {
        DetailsViewController(with: detailsViewModel)
    }
    
    var detailsViewModel: DetailsViewModel {
        DetailsViewModel(anime: anime,
                         animeRepository: dependency.animeRepository,
                         searchTerm: searchTerm)
    }
}

protocol DetailsBuilder {
    var detailsViewController: UIViewController { get }
}
