import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = MainNavigationController(rootViewController: HomeViewController())
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
