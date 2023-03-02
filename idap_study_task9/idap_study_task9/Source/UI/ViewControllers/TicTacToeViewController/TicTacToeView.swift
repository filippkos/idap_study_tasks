//
//  TicTacToeView.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 30.01.2023.
//

import UIKit

class TicTacToeView: UIView {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet weak var firstSquare: UIView?
    @IBOutlet weak var secondSquare: UIView?
    @IBOutlet weak var thirdSquare: UIView?
    @IBOutlet weak var fourthSquare: UIView?
    @IBOutlet weak var fifthSquare: UIView?
    @IBOutlet weak var sixthSquare: UIView?
    @IBOutlet weak var seventhSquare: UIView?
    @IBOutlet weak var eighthSquare: UIView?
    @IBOutlet weak var ninthSquare: UIView?
    @IBOutlet var button: UIButton?
    
    // MARK: -
    // MARK: Public
    
    func configure() {
        self.button?.layer.cornerRadius = 4
    }
    
    // MARK: -
    // MARK: Private

    public func squareAnimation(square: UIView, color: UIColor) {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                square.frame.size.height -= 10
                square.frame.size.width -= 10
                square.frame.origin.x += 5
                square.frame.origin.y += 5
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                square.backgroundColor = color
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                square.frame.size.height += 10
                square.frame.size.width += 10
                square.frame.origin.x -= 5
                square.frame.origin.y -= 5
            })
        })
        
    }
}
