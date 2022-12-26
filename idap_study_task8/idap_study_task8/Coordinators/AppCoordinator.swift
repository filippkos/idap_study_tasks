//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationViewController: UINavigationController
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func pushLaunchViewController() {
        let controller = LaunchViewController()
        controller.outputEvents = { [weak self] event in
            switch event {
            case .needShowPokemonList:
                self?.pushPokemonListViewController()
            case let .needShowAlert(error):
                self?.presentAlert(error: error, controller: controller)
            }
        }
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    func pushPokemonListViewController() {
        let controller = PokemonListViewController(pokemonProvider: PokemonProvider())
        controller.outputEvents = { [weak self] event in
            switch event {
            case let .needShowDetails(name):
                self?.pushPokemonViewController(name: name)
            case let .needShowAlert(error):
                self?.presentAlert(error: error, controller: controller)
            }
        }
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    func pushPokemonViewController(name: String) {
        let controller = PokemonViewController(pokemonProvider: PokemonProvider(), name: name)
        controller.outputEvents = { [weak self] event in
            switch event {
            case let .needShowAlert(error):
                self?.presentAlert(error: error, controller: controller)
            }
        }
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    func presentAlert(error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: "Error", message: (error as? NetworkResponce)?.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .cancel)
        alert.addAction(action)
        
        controller.present(alert, animated: true)
    }
}
