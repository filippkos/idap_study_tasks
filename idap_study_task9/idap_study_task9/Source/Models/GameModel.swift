//
//  GameModel.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 31.01.2023.
//

import Foundation

class GameModel {
    
    var squares: [Int]
    var stepCounter: Int
    var firstPlayer: PlayerModel
    var secondPlayer: PlayerModel

    
    let combinationsBool = [
        [true,true,true,false,false,false,false,false,false],
        [false,false,false,true,true,true,false,false,false],
        [false,false,false,false,false,false,true,true,true],
        [true,false,false,true,false,false,true,false,false],
        [false,true,false,false,true,false,false,true,false],
        [false,false,true,false,false,true,false,false,true],
        [true,false,false,false,true,false,false,false,true],
        [false,false,true,false,true,false,true,false,false],
    ]
    
    init(firstPlayer: PlayerModel, secondPlayer: PlayerModel) {
        self.stepCounter = 0
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.squares = [0,0,0,0,0,0,0,0,0]
    }
    
    func refresh() {
        self.stepCounter = 0
        self.squares = [0,0,0,0,0,0,0,0,0]
    }
}
