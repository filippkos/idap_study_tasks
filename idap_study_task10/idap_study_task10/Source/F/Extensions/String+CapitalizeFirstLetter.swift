//
//  String+CapitalizeFirstLetter.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 07.05.2023.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
