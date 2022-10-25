import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = self.window
        let model = AnimationInfo(sizeX: 100, sizeY: 100, color: .magenta)
        let controller = AnimationViewController(model: model)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        return true
    }

}

