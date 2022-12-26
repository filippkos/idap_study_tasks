//Created for idap_study_task8 in 2022
// Using Swift 5.0

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
        self.coordinator?.pushLaunchViewController()
        
        let window = self.window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
    }
}
