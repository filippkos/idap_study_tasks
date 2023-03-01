//
//  TicTacToeViewController.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 30.01.2023.
//

import UIKit

enum TicTacToeViewControllerOutputEvents {
    
    case needShowScore(game: GameModel)
    case needShowAlert(alertModel: AlertModel)
}

enum TicTacToeViewTexts: String {
    case win = " win"
    case nobodyWon = "Nobody won"
}

class TicTacToeViewController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: TypeAliases
    
    typealias RootView = TicTacToeView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((TicTacToeViewControllerOutputEvents) -> ())?
    private var stepCounter = 0
    private var game: GameModel
    
    private lazy var fields: [UIView?] = [
        self.rootView?.firstSquare,
        self.rootView?.secondSquare,
        self.rootView?.thirdSquare,
        self.rootView?.fourthSquare,
        self.rootView?.fifthSquare,
        self.rootView?.sixthSquare,
        self.rootView?.seventhSquare,
        self.rootView?.eighthSquare,
        self.rootView?.ninthSquare
    ]
    
    // MARK: -
    // MARK: Init
    
    init(firstPlayer: PlayerModel, secondPlayer: PlayerModel) {
        self.game = GameModel(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.configure()
        self.prepareTapGestures()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareTapGestures() {
        self.fields.forEach {
            self.prepareTapGestrure(on: $0)
        }
    }
    
    private func prepareTapGestrure(on view: UIView?) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.changeColor(_:))
        )
        
        view?.addGestureRecognizer(tap)
    }
    
    @objc private func changeColor(_ sender: UITapGestureRecognizer?) {
        let currentPlayer = self.stepCounter % 2 == 0 ? self.game.firstPlayer : self.game.secondPlayer

        sender?.view?.isUserInteractionEnabled = false
        
        self.game.squares[(sender?.view?.tag ?? 0) - 1] = currentPlayer.id
        
        if let square = self.fields[(sender?.view?.tag ?? 0) - 1] {
            self.rootView?.squareAnimation(square: square, color: currentPlayer.color!)
        }
        
        self.game.combinationsBool.forEach {
            var points = 0
            zip($0, self.game.squares).forEach {
                if $0.1 == currentPlayer.id && $0.0 {
                    points += 1
                }
            }
            
            if points > 2 {
                showAlert(text: currentPlayer.name + TicTacToeViewTexts.win.rawValue)
                
                if currentPlayer.id == 1 {
                    self.game.firstPlayer.points += 1
                } else {
                    self.game.secondPlayer.points += 1
                }
                
                zip($0, self.fields).forEach {
                    if $0.0 {
                        if let square = $0.1 {
                            self.rootView?.squareAnimation(square: square, color: .yellow)
                        }
                    }
                }
            }
        }
        
        self.stepCounter += 1
        if self.stepCounter >= 9 {
            showAlert(text: TicTacToeViewTexts.nobodyWon.rawValue)
        }
    }
    
    private func showAlert(text: String) {
        let alertModel = AlertModel(
            title: nil,
            message: text,
            actions: [UIAlertAction(
                title: "OK",
                style: .default,
                handler: {_ in
                    self.refresh()
                })
            ])
        
        self.outputEvents?(.needShowAlert(alertModel: alertModel))
    }
    
    private func refresh() {
        self.fields.forEach {
            $0?.backgroundColor = .lightGray
            $0?.isUserInteractionEnabled = true
        }
        self.game.squares = [0,0,0,0,0,0,0,0,0]
        self.stepCounter = 0
    }
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func scoreButton(_ sender: Any) {
        self.outputEvents?(.needShowScore(game: self.game))
    }
}
