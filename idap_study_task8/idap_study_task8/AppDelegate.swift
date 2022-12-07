import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Variables
    
    private let window = UIWindow()
    
    // MARK: -
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareRootController()
        
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        let window = self.window
        let searchHandler = PokemonSearchHandler()
        let controller = PokemonViewController(searchHandler: searchHandler)
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
