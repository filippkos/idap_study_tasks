//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

public protocol Coordinator: AnyObject {
    
    func pushPokemonListViewController()
    func pushPokemonViewController(name: String)
    func presentAlert(error: Error, controller: UIViewController)
}
