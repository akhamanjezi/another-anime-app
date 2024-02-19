import UIKit
import NeedleFoundation

protocol HomeDependency: Dependency {
    var homeViewModel: HomeViewModel { get }
}

class HomeComponent: Component<HomeDependency>, HomeBuilder {
    var homeViewController: UIViewController {
        HomeViewController(viewModel: dependency.homeViewModel, detailBuilder: detailComponent)
    }
    
    func detailComponent(for anime: Anime) -> DetailsComponent {
        DetailsComponent(parent: self, anime: anime)
    }
}

protocol HomeBuilder {
    var homeViewController: UIViewController { get }
}
