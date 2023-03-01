//
//  LaunchViewController.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 17.02.2023.
//

import UIKit

enum LaunchViewControllerOutputEvents {
    
    case startGame(firstPlayer: PlayerModel, secondPlayer: PlayerModel)
}

enum LaunchViewControllerInputEvents {
    
    case emptyField(field: CustomTextField)
    case onlyWhiteSpaces(field: CustomTextField)
    case equalNames
}

class LaunchViewController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: TypeAliases
    
    typealias RootView = LaunchView
    
    // MARK: -
    // MARK: Variables
    
    public var inputEvents: ((LaunchViewControllerInputEvents) -> ())?
    public var outputEvents: ((LaunchViewControllerOutputEvents) -> ())?

    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.configure()
    }
    
    // MARK: -
    // MARK: Private
    
    private func handleName(field: CustomTextField) -> Bool {
        let name = field.field.text ?? ""
        
        if name != "" { } else {
            self.rootView?.handleInputEvents(event: .emptyField(field: field))
            return false
        }
        
        if PlayerNameValidator.isValid(name) { } else {
            self.rootView?.handleInputEvents(event: .onlyWhiteSpaces(field: field))
            return false
        }
        
        field.errorLabel.text = ""
        return true
    }
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func button() {
        if let firstField = self.rootView?.firstField, let secondField = self.rootView?.secondField {
            if handleName(field: firstField) && handleName(field: secondField) {
                let firstName = self.rootView?.firstField.field.text ?? ""
                let secondName = self.rootView?.secondField.field.text ?? ""
                if !PlayerNameValidator.isEqual(firstName, secondName) {
                    let firstPlayer = PlayerModel(name: firstName, id: 1, points: 0)
                    let secondPlayer = PlayerModel(name: secondName, id: 2, points: 0)
                    firstPlayer.color = .green
                    secondPlayer.color = .red
                    self.outputEvents?(.startGame(firstPlayer: firstPlayer, secondPlayer: secondPlayer))
                } else {
                    self.rootView?.handleInputEvents(event: .equalNames)
                }
            }
        }
    }
}
