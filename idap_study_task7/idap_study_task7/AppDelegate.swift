import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: -
    // MARK: Variables

    let window = UIWindow()
    
    // MARK: -
    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = self.window
        let controller = TaskTableViewController()
        controller.stringArray = StringDataArray()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        return true
    }
}

