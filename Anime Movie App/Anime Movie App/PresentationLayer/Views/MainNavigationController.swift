import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            .font: UIFont.roundedLargeTitle
        ]
        navigationBar.titleTextAttributes = [
            .font: UIFont.roundedHeadline
        ]
    }
}
