import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    func setupWindow() {
        registerProviderFactories()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let rootComponent = RootComponent()
                
        window.rootViewController = rootComponent.rootView
        window.makeKeyAndVisible()
        
    }
}
