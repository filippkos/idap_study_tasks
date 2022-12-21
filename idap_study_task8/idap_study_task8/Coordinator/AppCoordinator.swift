import UIKit

class AppCoordinator: Coordinator {
    
    var navigationViewController: UINavigationController
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        let controller = PokemonListViewController(pokemonProvider: PokemonProvider())
        controller.coordinator = self
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    func details(name: String) {
        let controller = PokemonViewController(pokemonProvider: PokemonProvider(), name: name)
        controller.coordinator = self
        self.navigationViewController.pushViewController(controller, animated: false)
    }
}
