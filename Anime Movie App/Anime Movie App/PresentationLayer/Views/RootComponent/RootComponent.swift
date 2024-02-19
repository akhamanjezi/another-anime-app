import UIKit
import NeedleFoundation

class RootComponent: BootstrapComponent {
    var rootView: UINavigationController {
        MainNavigationController(rootViewController: homeComponent.homeViewController)
    }
    
    var homeComponent: HomeComponent {
        HomeComponent(parent: self)
    }
    
    public var homeViewModel: HomeViewModel {
        HomeViewModel()
    }
}

