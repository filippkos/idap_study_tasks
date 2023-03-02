//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum LaunchViewControllerOutputEvents {
    
    case needShowPokemonList
}

final class LaunchViewController: BaseViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = LaunchView
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func startButton(_ sender: Any) {
        self.outputEvents?(.needShowPokemonList)
    }
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((LaunchViewControllerOutputEvents) -> ())?
}
