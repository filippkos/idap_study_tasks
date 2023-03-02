//
//  LaunchView.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 17.02.2023.
//

import UIKit

enum LaunchViewTexts: String {
    case mainTitle = "Enter your names"
    case firstFieldLabel = "Player 1 name:"
    case secondFieldLabel = "Player 2 name:"
    case buttonTitle = "Start"
    case emptyField = "Field is empty"
    case onlyWhitespaces = "Not only whitespaces!"
    case equalNames = "Names don't have to be equal"
}

class LaunchView: UIView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var label: UILabel!
    @IBOutlet var firstField: CustomTextField!
    @IBOutlet var secondField: CustomTextField!
    @IBOutlet var button: UIButton!
    
    // MARK: -
    // MARK: Public
    
    func configure() {
        self.label.text = LaunchViewTexts.mainTitle.rawValue
        self.label.font = .systemFont(ofSize: 24)
        self.firstField.titleLabel.text = LaunchViewTexts.firstFieldLabel.rawValue
        self.secondField.titleLabel.text = LaunchViewTexts.secondFieldLabel.rawValue
        self.button?.setTitle(LaunchViewTexts.buttonTitle.rawValue, for: .normal)
        self.button?.layer.cornerRadius = 4
    }
    
    // MARK: -
    // MARK: Private
    
    func handleInputEvents(event: LaunchViewControllerInputEvents) {
        switch event {
            
        case .emptyField(let field):
            field.errorLabel.text = LaunchViewTexts.emptyField.rawValue
        case .onlyWhiteSpaces(let field):
            field.errorLabel.text = LaunchViewTexts.onlyWhitespaces.rawValue
        case .equalNames:
            firstField.errorLabel.text = LaunchViewTexts.equalNames.rawValue
            secondField.errorLabel.text = LaunchViewTexts.equalNames.rawValue
        }
    }
}
