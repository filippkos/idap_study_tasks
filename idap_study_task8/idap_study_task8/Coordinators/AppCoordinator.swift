//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

final class AppCoordinator: Coordinator {
    
    internal var navigationViewController: UINavigationController
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    internal func pushLaunchViewController() {
        let controller = LaunchViewController()
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    private func handle(event: LaunchViewControllerOutputEvents) {
        switch event {
        case .needShowPokemonList:
            self.pushPokemonListViewController()
        case let .needShowAlert(error):
            let alertModel = self.alertModel(error: error)
            self.presentAlert(alertModel: alertModel, controller: nil)
        }
    }
    
    internal func pushPokemonListViewController() {
        let controller = PokemonListViewController(pokemonProvider: PokemonProvider())
        controller.outputEvents = { [weak self] event in
            switch event {
            case let .needShowDetails(model):
                self?.pushPokemonViewController(pokemonModel: model)
            case let .needShowAlert(error):
                if let alertModel = self?.alertModel(error: error) {
                    self?.presentAlert(alertModel: alertModel, controller: controller)
                }
            }
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    func pushPokemonViewController(pokemonModel: PokemonModel) {
        let controller = PokemonViewController(
            pokemonProvider: PokemonProvider(),
            pokemonModel: pokemonModel
        )
        controller.outputEvents = { [weak self] event in
            switch event {
            case let .needShowAlert(error):
                if let alertModel = self?.alertModel(error: error) {
                    self?.presentAlert(alertModel: alertModel, controller: controller)
                }
            }
        }
        self.navigationViewController.pushViewController(controller, animated: false)
    }
}
