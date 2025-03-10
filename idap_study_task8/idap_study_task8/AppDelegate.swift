//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Variables
    
    private var coordinator: AppCoordinator?
    private var networkManager: NetworkManagerType?
    
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
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(serviceManager: self.serviceManager(), navigationViewController: navigationController)
        
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    private func serviceManager() -> ServiceManager {
        let networkManager = NetworkManager()
        let storageService = StorageService()
        let pokemonProvider = PokemonProvider(networkManager: networkManager)
        let imageService = ImageService(
            networkManager: networkManager,
            storageService: storageService
        )
        
        return .init(networkManager: networkManager, storageService: storageService, pokemonProvider: pokemonProvider, imageService: imageService)
    }
}
