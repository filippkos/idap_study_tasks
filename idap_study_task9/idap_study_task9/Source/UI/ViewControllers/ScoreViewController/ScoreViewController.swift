//
//  ScoreViewController.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 01.02.2023.
//

import UIKit

enum ScoreViewControllerOutputEvents {
    
    case needShowScore
    case needShowAlert(alertModel: AlertModel)
}

class ScoreViewController: UIViewController, RootViewGettable {
    
    
    // MARK: -
    // MARK: TypeAliases
    
    typealias RootView = ScoreView

    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((ScoreViewControllerOutputEvents) -> ())?
    private let game: GameModel
    
    // MARK: -
    // MARK: Init
    
    init(game: GameModel) {
        self.game = game
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(game: self.game)
    }
}
