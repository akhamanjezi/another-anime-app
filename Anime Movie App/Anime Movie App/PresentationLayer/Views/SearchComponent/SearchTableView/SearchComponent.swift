import UIKit
import NeedleFoundation

protocol SearchDependency: Dependency {
    var searchViewModel: SearchViewModel { get }
}

class SearchComponent: Component<SearchDependency>, SearchBuilder {
    var searchTableViewController: SearchTableViewController {
        SearchTableViewController(viewModel: dependency.searchViewModel, detailsBuilder: detailsComponent)
    }
    
    func detailsComponent(for anime: Anime, searchTerm: String?) -> DetailsComponent {
        DetailsComponent(parent: self, anime: anime, searchTerm: searchTerm)
    }
}

protocol SearchBuilder {
    var searchTableViewController: SearchTableViewController { get }
}
