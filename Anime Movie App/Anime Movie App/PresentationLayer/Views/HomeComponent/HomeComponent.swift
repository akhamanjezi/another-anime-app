import UIKit
import NeedleFoundation

protocol HomeDependency: Dependency {
    var homeViewModel: HomeViewModel { get }
}

class HomeComponent: Component<HomeDependency>, HomeBuilder {
    var homeViewController: UIViewController {
        HomeViewController(viewModel: dependency.homeViewModel)
    }
}

protocol HomeBuilder {
    var homeViewController: UIViewController { get }
}
