//
//  PlayerModel.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 28.02.2023.
//

import UIKit

class PlayerModel {
    
    // MARK: -
    // MARK: Variables
    
    var name: String
    var id: Int
    var color: UIColor?
    var points: Int
    
    init(name: String, id: Int, color: UIColor? = nil, points: Int) {
        self.name = name
        self.id = id
        self.color = color
        self.points = points
    }
    
}
