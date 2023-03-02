//
//  ScoreView.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 01.02.2023.
//

import UIKit

class ScoreView: UIView {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var firstPlayerTitle: UILabel!
    @IBOutlet weak var secondPlayerTitle: UILabel!
    @IBOutlet weak var firstPlayerScoreLabel: UILabel!
    @IBOutlet weak var secondPlayerScoreLabel: UILabel!
    
    public func fill(game: GameModel) {
        self.mainTitle.text = "Score:"
        self.firstPlayerTitle.text = game.firstPlayer.name
        self.secondPlayerTitle.text = game.secondPlayer.name
        self.firstPlayerScoreLabel.text = game.firstPlayer.points.description
        self.secondPlayerScoreLabel.text = game.secondPlayer.points.description
    }
}
