//
//  AlertModel.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

public struct AlertModel {
    
    let title: String
    let message: String
    let actions: [UIAlertAction]
    
    public init(title: String, message: String, actions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    public init(error: Error) {
        self.title = "Error"
        self.message = (error as? NetworkResponse)?.rawValue ?? ""
        self.actions = []
    }
}
