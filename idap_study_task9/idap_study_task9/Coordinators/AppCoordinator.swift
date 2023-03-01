//
//  AppCoordinator.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 01.02.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    var navigationViewController: UINavigationController
    
    // MARK: -
    // MARK: Init
    
    public init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
        self.navigationViewController.navigationBar.tintColor = .white
        self.prepareLaunchViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareLaunchViewController() {
        let controller = LaunchViewController()
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        
        self.navigationViewController.setViewControllers([controller], animated: true)
    }
    
    private func handle(event: LaunchViewControllerOutputEvents) {
        switch event {
        case .startGame(let firstPlayer, let secondPlayer):
            self.pushTicTacToeViewController(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        }
    }
    
    private func pushTicTacToeViewController(firstPlayer: PlayerModel, secondPlayer: PlayerModel) {
        let controller = TicTacToeViewController(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    private func handle(event: TicTacToeViewControllerOutputEvents) {
        switch event {
        case .needShowScore(game: let game):
            self.pushScoreViewController(game: game)
        case .needShowAlert(alertModel: let alertModel):
            self.presentAlert(alertModel: alertModel)
        }
    }
    
    private func pushScoreViewController(game: GameModel) {
        let controller = ScoreViewController(game: game)
        controller.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
        }
        
        self.navigationViewController.pushViewController(controller, animated: false)
    }
    
    private func handle(event: ScoreViewControllerOutputEvents, controller: UIViewController) {
        switch event {
        case .needShowScore:
            return
        case let .needShowAlert(alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        }
    }
}
