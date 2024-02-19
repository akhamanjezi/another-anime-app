import UIKit
import NeedleFoundation

protocol SearchDependency: Dependency {
    var searchViewModel: SearchViewModel { get }
}

class SearchComponent: Component<SearchDependency>, SearchBuilder {
    var searchTableViewController: SearchTableViewController {
        SearchTableViewController(viewModel: dependency.searchViewModel)
    }
}

protocol SearchBuilder {
    var searchTableViewController: SearchTableViewController { get }
}
