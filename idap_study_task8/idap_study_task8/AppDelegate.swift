import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Variables
    
    private let window = UIWindow()
    var coordinator: AppCoordinator?
    
    // MARK: -
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareRootController()
        
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationViewController: navigationController)
        self.coordinator?.start()
        
        let window = self.window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
    }
}
