//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum LaunchViewControllerOutputEvents {
    
    case needShowPokemonList
    case needShowAlert(error: Error)
}

class LaunchViewController: UIViewController {

    @IBAction func startButton(_ sender: Any) {
        self.outputEvents?(.needShowPokemonList)
    }
    
    public var outputEvents: ((LaunchViewControllerOutputEvents) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
