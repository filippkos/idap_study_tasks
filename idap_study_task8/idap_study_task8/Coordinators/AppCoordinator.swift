//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    internal var navigationViewController: UINavigationController
    private let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: Init
    
    public init(serviceManager: ServiceManager, navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
        self.serviceManager = serviceManager
        self.prepareLaunchViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareLaunchViewController() {
        let controller = LaunchViewController(serviceManager: self.serviceManager)
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        
        self.navigationViewController.setViewControllers([controller], animated: true)
    }
    
    private func handle(event: LaunchViewControllerOutputEvents) {
        switch event {
        case .needShowPokemonList:
            self.pushPokemonListViewController()
        }
    }
    
    private func pushPokemonListViewController() {
        let controller = PokemonListViewController(serviceManager: self.serviceManager)
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    private func handle(event: PokemonListViewControllerOutputEvents, controller: UIViewController) {
        switch event {
        case let .needShowDetails(model):
            self.pushPokemonViewController(pokemonModel: model)
        case let .needShowAlert(alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        }
    }
    
    private func pushPokemonViewController(pokemonModel: Pokemon) {
        let controller = PokemonViewController(
            serviceManager: self.serviceManager,
            pokemonModel: pokemonModel
        )
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    private func handle(event: PokemonViewControllerOutputEvents, controller: UIViewController) {
        switch event {
        case let .needShowAlert(alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        }
    }
}
