//
//  AlertModel.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 01.02.2023.
//

import UIKit

public struct AlertModel {
    
    let title: String?
    let message: String
    let actions: [UIAlertAction]
    
    public init(title: String? = nil, message: String, actions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}
