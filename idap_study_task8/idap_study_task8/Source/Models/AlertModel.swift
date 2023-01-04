//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

public struct AlertModel { // need create file
    
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
        self.message = (error as? NetworkResponce)?.rawValue ?? ""
        self.actions = []
    }
}
